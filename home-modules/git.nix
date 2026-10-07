{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.git.enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf config.redots.git.enable (
    lib.mkMerge [
      {
        programs.git = {
          enable = true;
          package = pkgs.gitFull;
          lfs.enable = true;
          settings = {
            user = {
              name = config.redots.user.fullname;
              email = config.redots.user.email;
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
      }
      (lib.mkIf config.redots.fish.enable {
        programs.fish.functions.cdg = "cd (${pkgs.git}/bin/git rev-parse --show-toplevel)";
      })
    ]
  );
}
