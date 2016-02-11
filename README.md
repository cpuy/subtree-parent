# Here is Subscription Pack source code
commit 1
## create
```shell
git remote add child ../subtree-child 
git subtree add --prefix=child child master
git push
```

## push
 ```shell
git subtree push --prefix=community git@github.com:cpuy/subtree-child.git master
```

## pull
```shell
git subtree pull --prefix=community git@github.com:cpuy/subtree-child.git master [--squash]
```

## cherry-pick
```shell
git cherry-pick -X subtree=community <ref>
```

![](victory.gif)
 new one
