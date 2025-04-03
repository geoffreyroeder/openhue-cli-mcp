<?xml version="1.0" encoding="UTF-8"?>
<development_plan>
  <title>Fork Development Setup (Revised)</title>
  <steps>
    <step>
      <id>1</id>
      <title>Configure Git Remote</title>
      <commands>
        <command>git remote -v</command>
        <command>git remote set-url origin git@github.com:geoffreyroeder/openhue-cli-mcp.git</command>
        <command>git fetch origin</command>
      </commands>
      <explanation>
        Set your fork as the sole remote for the repository.
        This isolates your development environment from the original repository.
      </explanation>
    </step>
    <step>
      <id>2</id>
      <title>Create Development Branch</title>
      <commands>
        <command>git checkout -b development</command>
        <command>git push -u origin development</command>
      </commands>
      <explanation>
        Create a new branch for development work and push it to your fork.
        This keeps your main branch clean for reference purposes.
      </explanation>
    </step>
    <step>
      <id>3</id>
      <title>Feature Branch Workflow</title>
      <commands>
        <command>git checkout development</command>
        <command>git checkout -b feature/your-feature-name</command>
        <command>git push -u origin feature/your-feature-name</command>
      </commands>
      <explanation>
        For each new feature, create a dedicated branch from development.
        This allows for clean pull requests to your development branch.
      </explanation>
    </step>
    <step>
      <id>4</id>
      <title>Manual Syncing with Original Repository (If Needed)</title>
      <commands>
        <command>git remote add upstream https://github.com/openhue/openhue-cli.git</command>
        <command>git fetch upstream</command>
        <command>git checkout main</command>
        <command>git merge upstream/main</command>
        <command>git push origin main</command>
        <command>git remote remove upstream</command>
      </commands>
      <explanation>
        If synchronization with the original repository becomes necessary:
        1. Temporarily add the original repository as an upstream remote
        2. Fetch and merge changes
        3. Remove the upstream remote afterward to maintain isolation
      </explanation>
    </step>
  </steps>
  <best_practices>
    <practice>
      <title>Commit Message Format</title>
      <description>
        Use conventional commit messages with type prefixes:
        - feat: New feature
        - fix: Bug fix
        - docs: Documentation only changes
        - style: Changes that don't affect code meaning
        - refactor: Code change that neither fixes a bug nor adds a feature
        - test: Adding or correcting tests
        - chore: Changes to build process or auxiliary tools
      </description>
    </practice>
    <practice>
      <title>Pull Request Workflow</title>
      <description>
        When a feature is complete:
        1. Create a pull request from feature branch to development branch
        2. After review and testing, merge to development
        3. For significant features, create a pull request from development to upstream
      </description>
    </practice>
  </best_practices>
</development_plan> 