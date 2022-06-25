# Diagramme MCD

![](Jarvis_mcd.png)


### MCD en MLD

Avec quelque modifications pour la mise en place des fonctionnalité.

```
Utilisateur (id_u, prenom_u, nom_u, email_u, date_de_naissance, mdp_u)

Membre (id_membre, lien_parente,#id_u)

Coproprietaire (id_copro,#id_u)

Proprietaire (id_prop,#id_u)

Domicile (id_domicile, annne_de_construction, superficie, #id_uProprietaire)

Appareil (id_appareil, nom_appareil, type_appareil, #id_piece)

Piece (id_piece, nom_piece, #id_domicile)

Inviter (#id_u, #id_pro, role_inviter,status_invitation, date_ajout_initation)

Habiter (#id_u, #id_domicile)
```

# Diagramme EER

![](Jarvis_eer.png)
1- Le fichier ```jarvis_eer.mwb``` contient la source du diagramme EER
2- Le Fichier ```Source_Jarvis.sql``` contient la code SQL pour la création de la Base de Donné
3- Le Fichier ```Invitation_Checker_Event.SQL ``` contient le code SQL ppour la création d'un évènement (SCHEDULE EVENT ) Qui s'execute toute les 30minute pour suprimé les invitation invalide de la table Inviter. 
