# Reponses

# 1-
## Exercice 1

### Targets :
Les targets dans un projet Swift définissent les composants individuels qu’Xcode doit construire et configurer pour créer un produit spécifique, comme une application, une extension, ou un framework. Chaque target possède ses propres paramètres, comme le type de produit, les ressources incluses (fichiers Swift, Storyboards, etc.), et les dépendances. Cela permet de gérer plusieurs variantes d’un projet dans une seule structure, par exemple, une version iOS et une version macOS d’une même application.

### Fichiers de base :
Les fichiers de base dans un projet Swift avec UIKit sont essentiels au fonctionnement de l’application. Le AppDelegate.swift gère les événements globaux de l’application (comme son lancement et sa mise en arrière-plan). Le SceneDelegate.swift est responsable de la gestion des fenêtres et scènes pour les applications iOS 13 et ultérieures. Le Main.storyboard permet de concevoir visuellement les interfaces utilisateurs et les transitions entre les écrans. Le ViewController.swift contient le code pour gérer les interactions et le comportement d’un écran spécifique. Enfin, le fichier Info.plist stocke les configurations essentielles de l’application, comme son nom ou ses autorisations.

### Assets.xcassets
Dossier où sont stockées les ressources comme les images ou les couleurs personnalisées.

### Storyboard : 
Le fichier Storyboard est un outil graphique où tu peux glisser-déposer des éléments d’interface (boutons, labels, etc.) pour concevoir l’apparence et le flux de ton application. Chaque écran correspond à une “scene”, et tu peux les relier par des transitions (“segue”) pour naviguer entre eux.

### Simulateur :
Le simulateur permet de tester ton application sur différents modèles d’appareils iOS sans avoir besoin de matériel physique. Il simule le comportement de l’application comme sur un vrai appareil (interactions utilisateur, affichage, etc.).

## Exercice 2

### Cmd + R 
Le raccourci Cmd + R dans Xcode sert à exécuter (Run) le projet. Il compile l’application et la lance directement dans le simulateur ou sur un appareil connecté pour tester son fonctionnement.

### Cmd + shift + O :
Le raccourci Cmd + Shift + O dans Xcode sert à ouvrir rapidement un fichier, une classe, une méthode ou une ressource. Il affiche une barre de recherche où tu peux taper le nom de l’élément que tu cherches, et Xcode te propose des correspondances instantanées.

### Pour indenter le code automztiquement : 
control + I

### Pour commenter et décommenter : 
Cmd + /

# 3-

## Exercice 1
Cela permet d’accéder à cette propriété sans avoir besoin de créer une instance.

## Exercice 2
Le dequeueReusableCell améliore les performances en réutilisant les cellules visibles d’un tableau, réduisant ainsi la consommation de mémoire et accélérant le défilement, surtout pour les longues listes.

# 4-

## Exercice 1

Nous venons de créer une navigation dans notre application. Le NavigationController gère la navigation entre les écrans et la barre de navigation, permettant de pousser et de revenir facilement entre les vues.

Non, le navigation controller gère la navigation entre les écrans, tandis que la navigation bar est la barre en haut de l’écran avec le titre et les boutons de navigation. La barre fait partie du controller.

# 6-

## Exercice 1

Un segue est une transition entre deux écrans (view controllers). Il permet de naviguer d’un écran à l’autre. Ils rendent la navigation et les animations entre vues beaucoup plus simples à gérer.

## Exercice 2 

Une constraint définit la position et la taille d’un élément par rapport à d’autres éléments ou à son parent. Elle fait partie du système Auto Layout, qui permet à l’interface de s’adapter automatiquement aux différentes tailles d’écran et orientations en appliquant ces règles.

### Expliquez ce qu’est un #selector en Swift

En Swift, un #selector est utilisé pour connecter des actions, comme des événements d’interface utilisateur, à des fonctions spécifiques. Il est utilisé notamment avec des cibles (target) et des actions (action) pour des composants comme les boutons.

### Que représente .add dans notre appel ?

.add est une valeur énumérée (de type UIBarButtonItem.SystemItem) qui représente un bouton système standard affichant une icône de type “Ajouter” (un signe +).

### Expliquez également pourquoi XCode vous demande de mettre le mot clé @objc devant la fonction ciblée par le #selector 

Le mot-clé @objc est nécessaire pour que Swift rende la méthode accessible à l’API d’Objective-C, ce qui permet au #selector de l’utiliser pour lier l’action du bouton.

### Peut-on ajouter plusieurs boutons dans la barre de navigation ? Si oui, comment en code ?

Oui, on peut ajouter plusieurs boutons dans la barre de navigation. Pour cela, vous devez utiliser la propriété rightBarButtonItems (pour les boutons à droite) ou leftBarButtonItems (pour les boutons à gauche) de navigationItem, qui accepte un tableau de UIBarButtonItem.