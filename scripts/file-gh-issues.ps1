# File dispatch-ready GitHub issues for squad-select-post-battle-shop and hero-class-archetypes.
# Prerequisite: gh auth login  (or set GH_TOKEN)
# Usage: pwsh -File scripts/file-gh-issues.ps1

$ErrorActionPreference = "Stop"
$MetaRepo = "bwhittington/breakfast-of-champions-meta-repo"
$GameRepo = "bwhittington/breakfast-of-champions"
# scripts/ → meta-repo root
$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
if (-not (Test-Path (Join-Path $Root "openspec"))) {
    throw "Expected openspec/ under meta root: $Root"
}

function Ensure-Label {
    param([string]$Repo, [string]$Name, [string]$Color, [string]$Description = "")
    $names = gh label list --repo $Repo --limit 100 --json name | ConvertFrom-Json | ForEach-Object { $_.name }
    if ($names -contains $Name) {
        return
    }
    gh label create $Name --repo $Repo --color $Color --description $Description
    if ($LASTEXITCODE -ne 0) {
        # Race or already exists — ignore
        Write-Host "  (label may already exist: $Name)"
    }
}

function Bootstrap-Labels {
    param([string]$Repo)
    Write-Host "Bootstrapping labels on $Repo..."
    $labels = @(
        @{ Name = "bug"; Color = "d73a4a"; Desc = "Something isn't working" },
        @{ Name = "enhancement"; Color = "a2eeef"; Desc = "New feature or request" },
        @{ Name = "documentation"; Color = "0075ca"; Desc = "Documentation" },
        @{ Name = "priority:P0"; Color = "b60205"; Desc = "Critical" },
        @{ Name = "priority:P1"; Color = "d93f0b"; Desc = "High" },
        @{ Name = "priority:P2"; Color = "fbca04"; Desc = "Medium" },
        @{ Name = "priority:P3"; Color = "0e8a16"; Desc = "Low" },
        @{ Name = "lane:leaf"; Color = "c5def5"; Desc = "Leaf / isolated change" },
        @{ Name = "lane:plumbing"; Color = "5319e7"; Desc = "Shared plumbing" },
        @{ Name = "ready-to-dispatch"; Color = "1d76db"; Desc = "Ready for agent dispatch" },
        @{ Name = "needs-spec-input"; Color = "e99695"; Desc = "Blocked on spec" },
        @{ Name = "blocked"; Color = "000000"; Desc = "Blocked" },
        @{ Name = "agent-claimed"; Color = "fef2c0"; Desc = "Agent working" },
        @{ Name = "do-not-dispatch"; Color = "666666"; Desc = "Hold dispatch" },
        @{ Name = "subsystem:game-loop"; Color = "006b75"; Desc = "Game loop" },
        @{ Name = "subsystem:characters"; Color = "006b75"; Desc = "Characters" },
        @{ Name = "subsystem:map-system"; Color = "006b75"; Desc = "Map system" },
        @{ Name = "subsystem:meta"; Color = "006b75"; Desc = "Meta / specs" }
    )
    foreach ($l in $labels) {
        Ensure-Label -Repo $Repo -Name $l.Name -Color $l.Color -Description $l.Desc
    }
}

function New-GhIssue {
    param(
        [string]$Repo,
        [string]$Title,
        [string]$BodyFile,
        [string[]]$Labels
    )
    if (-not (Test-Path $BodyFile)) {
        throw "Body file missing: $BodyFile"
    }
    $labelArgs = @()
    foreach ($lab in $Labels) {
        $labelArgs += @("--label", $lab)
    }
    & gh issue create --repo $Repo --title $Title --body-file $BodyFile @labelArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create issue: $Title"
    }
}

gh auth status | Out-Null

Write-Host "Bootstrapping labels..."
Bootstrap-Labels $MetaRepo
Bootstrap-Labels $GameRepo

$issues = @(
    @{
        Repo = $MetaRepo
        Title = "docs: canonical party cap, shop flow, six heroes (squad-select §1)"
        Body = Join-Path $Root "openspec/changes/squad-select-post-battle-shop/gh-issues/01-meta-canonical-party-session.md"
        Labels = @("enhancement", "priority:P2", "lane:leaf", "subsystem:meta", "ready-to-dispatch")
    },
    @{
        Repo = $GameRepo
        Title = "feat: roster six heroes, party_ids array, run currency (squad-select §2)"
        Body = Join-Path $Root "openspec/changes/squad-select-post-battle-shop/gh-issues/02-game-roster-party-model.md"
        Labels = @("enhancement", "priority:P2", "lane:plumbing", "subsystem:characters", "ready-to-dispatch")
    },
    @{
        Repo = $GameRepo
        Title = "feat: post-battle shop stub after combat win (squad-select §3)"
        Body = Join-Path $Root "openspec/changes/squad-select-post-battle-shop/gh-issues/03-game-post-battle-shop.md"
        Labels = @("enhancement", "priority:P2", "lane:leaf", "subsystem:game-loop", "ready-to-dispatch")
    },
    @{
        Repo = $GameRepo
        Title = "feat: character select pick 3 from roster (squad-select §4)"
        Body = Join-Path $Root "openspec/changes/squad-select-post-battle-shop/gh-issues/04-game-character-select.md"
        Labels = @("enhancement", "priority:P2", "lane:leaf", "subsystem:characters", "ready-to-dispatch")
    },
    @{
        Repo = $MetaRepo
        Title = "docs: canonical hero classes and stat baselines (hero-class §1)"
        Body = Join-Path $Root "openspec/changes/hero-class-archetypes/gh-issues/01-meta-canonical-hero-classes.md"
        Labels = @("enhancement", "priority:P2", "lane:leaf", "subsystem:meta", "ready-to-dispatch")
    },
    @{
        Repo = $GameRepo
        Title = "feat: class baselines resource and roster class field (hero-class §2)"
        Body = Join-Path $Root "openspec/changes/hero-class-archetypes/gh-issues/02-game-class-baselines-roster.md"
        Labels = @("enhancement", "priority:P2", "lane:leaf", "subsystem:characters", "ready-to-dispatch")
    },
    @{
        Repo = $GameRepo
        Title = "feat: apply class baselines on party init (hero-class §3)"
        Body = Join-Path $Root "openspec/changes/hero-class-archetypes/gh-issues/03-game-class-init-harness.md"
        Labels = @("enhancement", "priority:P2", "lane:leaf", "subsystem:characters", "ready-to-dispatch")
    }
)

Write-Host "Creating issues..."
foreach ($i in $issues) {
    $url = New-GhIssue -Repo $i.Repo -Title $i.Title -BodyFile $i.Body -Labels $i.Labels
    Write-Host "Created: $url"
}

Write-Host "Done. 7 issues filed."
