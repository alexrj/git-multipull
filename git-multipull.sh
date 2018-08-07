#/bin/bash

# Alessandro Ranellucci
# Team per la Trasformazione Digitale - Presidenza del Consiglio dei Ministri

# Loop through repos, fetch them and compare their tips.
echo "Fetching remotes..."
tip=""
for repo in `cat repos.txt`; do
    # Strip https:// from the URLs in order to get a valid refspec name
    branch=${repo/#https:\/\//}
    
    # Fetch the repository to its own local branch
    echo git fetch $repo master:$branch
    git fetch $repo master:$branch
    if [ $? -ne 0 ]; then
        echo "FATAL: Fetch failed. Please check network status and authenticity of the repositories."
        exit $?
    fi
    
    # Compare the tip of this repository with the previous one.
    if [ "$tip" == "" ]; then
        tip=`git rev-parse $branch`
    elif [ "$tip" != `git rev-parse $branch` ]; then
        echo "FATAL: Security check failed: tips of remotes don't match. Please check authenticity of the repositories."
        exit 1
    fi
done
echo "Security check succeeded: remotes are aligned ($tip)."

echo "Checking out files..."
echo git merge $tip
git merge $tip
