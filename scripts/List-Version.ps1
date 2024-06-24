# Set the base directory
$baseDir = "E:\www\demo"

# Get all directories in the base directory
$projects = Get-ChildItem -Path $baseDir -Directory

# Initialize an array to hold the results
$results = @()

# Loop through each directory and run php artisan version
foreach ($project in $projects) {
    $projectPath = $project.FullName
    Write-Host "Getting version for project in $projectPath"
    
    # Change to the project directory
    cd $projectPath

    # Run 'php artisan version' and capture the output
    $versionOutput = & php artisan --version 2>&1

    # Capture the result in the array
    $results += [PSCustomObject]@{
        Project = $project.Name
        Path = $projectPath
        Version = $versionOutput
    }
}

# Generate the Markdown table
$markdownTable = @"
| Project | Path | Version |
|---------|------|---------|
"@

foreach ($result in $results) {
    $markdownTable += "| $($result.Project) | $($result.Path) | $($result.Version) |`n"
}

# Output the Markdown table
$markdownTable | Out-File "E:\code\repo\laravel-powershell-script\project_versions.md"
Write-Host "All projects' versions have been collected and saved to project_versions.md"
