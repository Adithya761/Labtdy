# PowerShell demo to show blobs, trees and commit objects in Git
# Safe: runs in a temporary directory and doesn't touch the current repo

$tmp = Join-Path $env:TEMP "git-tree-demo-$(Get-Random)"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Push-Location $tmp
Write-Output "Demo repo created at: $tmp"

git init -q

# Create two files
Set-Content -Path file1.txt -Value "Hello from file 1"
Set-Content -Path file2.txt -Value "Second file content"

# Write blobs directly (equivalent to git add + write object)
$blob1 = git hash-object -w file1.txt
$blob2 = git hash-object -w file2.txt
Write-Output "Blob1: $blob1"
Write-Output "Blob2: $blob2"

# Use index to create a tree object
git update-index --add --cacheinfo 100644,$blob1,file1.txt
git update-index --add --cacheinfo 100644,$blob2,file2.txt
$tree = git write-tree
Write-Output "Tree: $tree"

# Create a commit object pointing to the tree
$commit = echo "Demo commit" | git commit-tree $tree
Write-Output "Commit: $commit"

# Inspect objects
Write-Output "\n--- Commit object ---"
git cat-file -p $commit

Write-Output "\n--- Tree contents ---"
git ls-tree $tree

# Inspect blob content
Write-Output "\n--- Blob1 content ---"
git cat-file -p $blob1

Write-Output "\n--- Blob2 content ---"
git cat-file -p $blob2

# Clean up: pop location and leave temp folder for inspection
Pop-Location
Write-Output "Demo finished. Temp repo left at: $tmp"
