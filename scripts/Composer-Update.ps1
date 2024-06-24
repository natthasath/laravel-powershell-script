# Set the base directory
$baseDir = "E:\www\demo"

# Get all directories in the base directory
$projects = Get-ChildItem -Path $baseDir -Directory

# Loop through each directory and run composer update
foreach ($project in $projects) {
    $projectPath = $project.FullName
    Write-Host "Updating project in $projectPath"
    cd $projectPath
    Start-Process -NoNewWindow -Wait -FilePath "composer" -ArgumentList "update"
    Write-Host "Finished updating project in $projectPath"
}

Write-Host "All projects have been updated."
