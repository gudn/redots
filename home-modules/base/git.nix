{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.my.base.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      lfs.enable = true;
      settings = {
        user = {
          name = config.my.user.fullname;
          email = config.my.user.email;
        };

        alias = {
          lo = "log --oneline --graph";
          los = "log --oneline --graph --stat";
          lop = "log --oneline --graph --stat --patch";
          st = "status -s";
          fixlast = "commit --amend --no-edit";
        };

        init.defaultBranch = "master";

        push.followTags = true;
        pull.rebase = true;
        fetch = {
          prune = true;
          prunetags = true;
        };
        transfer.fsckobjects = true;

        commit.verbose = true;
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        rebase = {
          autosquash = true;
          updateRefs = true;
          missingCommitCheck = "error";
        };
        merge.conflictStyle = "zdiff3";
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
        };

        core.quotePath = true;
        branch.sort = "-committerdate";
        tag.sort = "-creatordate";
        log.date = "iso";
      };
    };

    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          tabWidth = 2;
          timeFormat = "2006-01-02";
          shortTimeFormat = "15:04";
          showCommandLog = false;
          showBottomLine = false;
        };
        git = {
          autoForwardBranches = "none";

          pagers = [
            {
              pager = builtins.replaceStrings [ "\n" ] [ " " ] ''
                ${pkgs.delta}/bin/delta
                  --dark
                  --paging=never
                  --line-numbers
                  --hunk-header-style syntax
                  --syntax-theme gruvbox-dark
                  --tabs 2
                  --hyperlinks
                  --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"
              '';
            }
          ];
        };
        update = {
          method = "never";
        };
      };
    };
  };
}
