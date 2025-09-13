# Git Commands

## Initialize Git

To initialize a new Git repository, navigate to your project directory in the terminal:
```bash
cd "C:\Path\To\Your\WoW\_classic_\Interface\AddOns\HerbalismTracker"
```

and run:
```bash
git init
```

This command creates a new subdirectory named `.git` that contains all of your necessary repository files. At this point, you have an empty Git repository.

Now add files to staging area:
```bash
git add .
```

The staging area is where you prepare a snapshot of your changes before committing them to the project history. This command stages all files in the current directory and its subdirectories for the next commit. The `.` indicates that you want to add all files.

However, you can ignore certain files by creating a `.gitignore` file in your project root and listing the files or directories you want Git to ignore.

For example, to ignore temporary files and logs, your `.gitignore` file might look like this:
```
# Ignore temporary files
*.tmp
*.log
.DS_Store
```

After staging your files, you need to commit them to the repository:
```bash
git commit -m "Initial commit - Herbalism Tracker v1.0"
```

This command captures a snapshot of the project's currently staged changes. The `-m` flag allows you to include a commit message, which is a brief description of the changes being committed.


## Create Repository on GitHub

- Go to GitHub.com and sign in
- Click the "+" icon in the top right → "New repository"
- Fill in repository details:
  - *Repository name*: wow-herbalism-tracker
  - *Description*: World of Warcraft Classic addon for tracking herbalism nodes
  - *Visibility*: Public (or Private if you prefer)
  - *DON'T initialize with README*: (since you already have files)
  - Do not add .gitignore or license (for now)
- Click "Create repository"


## Link Local Repository to GitHub

- Add your GitHub repository as remote origin
```bash
git remote add origin https://github.com/YOUR_USERNAME/wow-herbalism-tracker.git
```

- Push your code to GitHub
```bash
git push -u origin main
```


## Subsequent Commits and Pushes

For subsequent changes, you can follow these steps:
1. Stage your changes:
   ```bash
   git add .
   ```
2. Commit your changes with a descriptive message:
 ```bash
   git commit -m "Your descriptive commit message"
   ```
3. Push your changes to GitHub:
   ```bash
   git push origin main
   ```

You can check your current branch with:
```bash
git branch
```

You can create releases on GitHub by tagging commits. For example, to tag a commit for version 1.0.1:
```bash
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```


## Unlink GitHub Repository
If you need to unlink your local repository from the GitHub repository, you can remove the remote origin by running:
```bash
git remote remove origin
```

This command removes the link between your local repository and the remote GitHub repository. You can verify that the remote has been removed by running:
```bash
git remote -v
```

This should return no results, indicating that there are no remote repositories linked to your local repository.


## Remove Git Tracking
If you want to completely remove Git tracking from your project, you can delete the `.git` directory:
```bash
rm -rf .git
```

This command deletes the `.git` directory and all its contents, effectively removing all version control information from your project.

Be cautious with this step, as it will remove all version history and Git tracking for your project.