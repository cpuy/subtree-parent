# subtree-parent
git remote add child ../subtree-child 
git subtree add --prefix=child child master
git read-tree --prefix=child -u child/master
git commit -m "Ajout du repo child"
