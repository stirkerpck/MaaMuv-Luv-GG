<#
.SYNOPSIS
  设置 MuvLuv 探索开始等级 (START AREA) 的目标等级。
  自动同时更新 MuvLuv_LevelTarget.expected 和方向判断正则 MuvLuv_LevelAbove.expected。

.DESCRIPTION
  等级范围 1~400。方向判断正则会自动生成，匹配 [目标+1 .. 400]，
  即“当前等级大于目标”时点左箭头(减)，否则点右箭头(加)。

.EXAMPLE
  .\tools\set_level.ps1 200
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidateRange(1, 400)]
    [int]$Level,

    [string]$ConfigPath = ""
)
$ErrorActionPreference = 'Stop'

if (-not $ConfigPath) {
    $ConfigPath = Join-Path $PSScriptRoot '..\assets\resource\pipeline\start.json'
}
$ConfigPath = (Resolve-Path -LiteralPath $ConfigPath).Path

function Convert-Digit([char]$c) { [int][char]$c - 48 }
function Char-FromDigit([int]$d) { [char]([int][char]'0' + $d) }

function Build-RangeRegex([string]$s, [string]$e) {
    $L = $s.Length
    if ($s -eq $e) { return $s }
    $fs = Convert-Digit $s[0]
    $fe = Convert-Digit $e[0]
    if ($fs -eq $fe) { return (Char-FromDigit $fs) + (Build-RangeRegex ($s.Substring(1)) ($e.Substring(1))) }
    $p = [System.Collections.Generic.List[string]]::new()
    if ($L -eq 1) { $p.Add((Char-FromDigit $fs)) }
    else { $p.Add((Char-FromDigit $fs) + (Build-RangeRegex ($s.Substring(1)) ("9" * ($L - 1)))) }
    for ($c = $fs + 1; $c -le $fe - 1; $c++) {
        if ($L -eq 1) { $p.Add((Char-FromDigit $c)) }
        else { $p.Add((Char-FromDigit $c) + ("[0-9]" * ($L - 1))) }
    }
    if ($L -eq 1) { $p.Add((Char-FromDigit $fe)) }
    else { $p.Add((Char-FromDigit $fe) + (Build-RangeRegex ("0" * ($L - 1)) ($e.Substring(1)))) }
    if ($p.Count -eq 1) { return $p[0] }
    return "(?:" + ($p -join "|") + ")"
}

function New-NumericRangeRegex([int]$lo, [int]$hi) {
    # 空区间: 返回一个不含反斜杠、绝不会命中数字的“不匹配”正则
    if ($lo -gt $hi) { return '[A-Za-z]' }
    $parts = [System.Collections.Generic.List[string]]::new()
    for ($L = "$lo".Length; $L -le "$hi".Length; $L++) {
        $start = [Math]::Max($lo, [Math]::Pow(10, $L - 1))
        $end   = [Math]::Min($hi, [Math]::Pow(10, $L) - 1)
        if ($start -gt $end) { continue }
        $parts.Add((Build-RangeRegex ("$start".PadLeft($L, '0')) ("$end".PadLeft($L, '0'))))
    }
    if ($parts.Count -eq 1) { return "(?:" + $parts[0] + ")" }
    return "(?:" + ($parts -join "|") + ")"
}

# 生成方向正则: 匹配 [Level+1 .. 400]
$above = New-NumericRangeRegex ($Level + 1) 400

# 自检: 在真实等级域 1..400 内，正则应恰好匹配 大于目标 的数字
$selfCheckOk = $true
for ($n = 1; $n -le 400; $n++) {
    $m = [regex]::IsMatch("$n", $above)
    $should = ($n -ge ($Level + 1))
    if ($m -ne $should) { $selfCheckOk = $false; break }
}
if (-not $selfCheckOk) { throw "生成的方向正则自检失败，已中止。目标=$Level 正则=$above" }

$content = Get-Content -LiteralPath $ConfigPath -Raw

$patternTarget = '(?s)("MuvLuv_LevelTarget":\s*\{.*?"expected":\s*\[\s*)"\d+"(\s*\])'
$patternAbove  = '(?s)("MuvLuv_LevelAbove":\s*\{.*?"expected":\s*\[\s*)"[^"]*"(\s*\])'

# 正则插入 JSON 前转义反斜杠 / 引号
$aboveJson = $above.Replace('\', '\\').Replace('"', '\"')

$new = [regex]::Replace($content, $patternTarget, {
    param($m) $m.Groups[1].Value + '"' + $Level + '"' + $m.Groups[2].Value
})
$new = [regex]::Replace($new, $patternAbove, {
    param($m) $m.Groups[1].Value + '"' + $aboveJson + '"' + $m.Groups[2].Value
})

if ($new -eq $content) { throw "未找到可替换的 MuvLuv_LevelTarget / MuvLuv_LevelAbove 节点，请检查 start.json。" }

$null = $new | ConvertFrom-Json -ErrorAction Stop

[System.IO.File]::WriteAllText($ConfigPath, $new, (New-Object System.Text.UTF8Encoding($false)))

Write-Host "OK 目标等级 = $Level"
Write-Host "   MuvLuv_LevelTarget.expected = [\"$Level\"]"
Write-Host "   MuvLuv_LevelAbove.expected  = \"$aboveJson\""
