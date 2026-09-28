# Installazione skill Feature-Driven Workflow per Claude Code (Windows)
# Uso: .\install.ps1

$ErrorActionPreference = 'Stop'

$skills = @(
    'spec',
    'clarify',
    'plan-tasks',
    'analyze',
    'implement',
    'test',
    'review',
    'refactor',
    'commit',
    'guardrail-scope'
)

$sourceDir = $PSScriptRoot
$targetDir = Join-Path $env:USERPROFILE '.claude\skills'

Write-Host "Installazione skill in: $targetDir" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Write-Host "Creata directory $targetDir"
}

# Copia (o sovrascrivi) le skill correnti
$installed = 0
foreach ($skill in $skills) {
    $src = Join-Path $sourceDir $skill
    $dst = Join-Path $targetDir $skill

    if (-not (Test-Path $src)) {
        Write-Warning "Sorgente mancante: $src (skip)"
        continue
    }

    if (Test-Path $dst) {
        Remove-Item -Recurse -Force $dst
    }

    Copy-Item -Recurse -Path $src -Destination $dst
    Write-Host "  OK  $skill" -ForegroundColor Green
    $installed++
}

Write-Host ""
Write-Host "Installate $installed/$($skills.Count) skill." -ForegroundColor Cyan
Write-Host "Riavvia Claude Code per caricarle."
