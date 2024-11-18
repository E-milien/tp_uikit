# Reponses

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
Cmd + I

### Pour commenter et décommenter : 
Cmd + /