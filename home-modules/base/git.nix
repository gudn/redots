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
        tag.sort = "-taggerdate";
        log.date = "iso";
      };
    };
  };
}
