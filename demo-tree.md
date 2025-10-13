Demo: Git tree/blob/commit objects

This demo shows how Git stores blobs, trees and commits at the object level using plumbing commands.

Files created by the demo script:
- demo-tree.md (this file)
- run-demo-tree.ps1 (PowerShell script to run the demo)

Steps the script performs (safe: uses a temporary folder):
1. Create a temporary directory and initialize a new git repository there.
2. Create two small files and write blob objects using `git hash-object -w`.
3. Use the index and `git write-tree` to create a tree object from the files.
4. Create a commit object with `git commit-tree` pointing to the tree.
5. Use `git cat-file -p` and `git ls-tree` to show the blob/tree/commit contents and hashes.

How to run:
1. Open PowerShell in this repo and run:
   .\run-demo-tree.ps1

Notes:
- The script won't modify your current repository; it works in a temporary folder.
- You'll see printed object hashes and their contents so you can inspect how trees reference blobs.
