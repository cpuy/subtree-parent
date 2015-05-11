# Here is Subscription Pack source code

## create
```shell
git remote add child ../subtree-child 
git subtree add --prefix=child child master
git push
```

## push
 ```shell
git subtree push --prefix=child git@github.com:cpuy/subtree-child.git master
```

## pull
```shell
git subtree pull --prefix=child git@github.com:cpuy/subtree-child.git master --squash
```

![](victory.gif)
