use bdd_mysql

-- 1) Afficher tous les employés de la société --
select NOM, PRENOM 
from employes

-- 2) Afficher toutes les catégories de la société --
select NOM_CATEGORIE 
from categories

-- 3) Afficher les noms, prénoms et date de naissance et la commission (à 0 si pas de commission) de tous les employés de la société --
select NOM, PRENOM, DATE_NAISSANCE, ifnull(COMMISSION, 0)
from employes

-- 4) Afficher la liste des fonctions des employés de la société) -- 
select distinct (FONCTION)
from employes 

-- 5) Afficher la liste des pays de nos clients -- 
select SOCIETE, PAYS
from clients

-- 6) Afficher la liste des localités dans lesquelles il existe au moins un client --
select distinct (VILLE)
from clients

-- 7) Afficher les produits commercialisés et la valeur de stock par produit (prix unitaire*quantité en stock) --
select NOM_PRODUIT, PRIX_UNITAIRE*UNITES_STOCK as 'stock'
from produits 

-- 8) Afficher le nom, le prénom, l'âge et l'ancienneté des employés, dans la société  --
select NOM, PRENOM, year(curdate())-year(DATE_NAISSANCE) as 'âge', year(curdate())-year(DATE_EMBAUCHE) as 'ancienneté'
from employes 

-- 9) Ecrivez la requête qui permet d'afficher : Employé a un gain annuel sur 12 mois / Fuller gagne 12000 par an   --
select NOM as 'Employé', 'gagne' as 'a un', (SALAIRE + IFNULL(COMMISSION,0)) * 12 as 'gain annuel', 'par an' as ' sur 12 mois'
from employes 

-- 10) Afficher le nom de la société et les pays des clients qui habitent à Toulouse-- 
select SOCIETE, PAYS 
from clients 
where ville = 'Toulouse'

-- 11) Afficher le nom, prénom et fonction des employés dirigés par l'employé numéro 2 -- 
select NOM, PRENOM, FONCTION 
from employes 
where REND_COMPTE ="2"

-- 12) Afficher le nom, prénom et fonction des employés qui ne sont pas des représentants --
select NOM, PRENOM, FONCTION 
from employes 
where FONCTION != 'ReprÃ©sentant(e)'

-- 13) Afficher le nom, prénom et fonction des employés qui ont un salaire < 3500€ --
select NOM, PRENOM, FONCTION, SALAIRE 
from employes 
where SALAIRE < "3500"

-- 14) Afficher le nom de la société, la ville et les pays des clients qui n'ont pas de fax --
select SOCIETE, VILLE, PAYS 
from clients
where fax = ''

-- 15) Afficher le nom, prénom et fonction des employés qui n'ont pas de supérieur --
select NOM, PRENOM, FONCTION 
from employes 
where REND_COMPTE = NO_EMPLOYE 

-- 16) Trier les employés par nom de salariés en ordre décroissant -- 
select NOM
from employes 
order by NOM desc 

-- 17)  Trier les clients par pays -- 
select SOCIETE, PAYS 
from clients 
order by pays 

-- 18) Trier les clients par pays et par ville --
select SOCIETE, PAYS, VILLE 
from clients 
order by pays, ville  

-- 19) Affichez le nom, prénom, fonction et salaire des employés qui ont un salaire compris entre 2500 et 3500 --
select NOM, PRENOM, FONCTION, SALAIRE 
from employes 
where SALAIRE between 2500 and 3500


-- 20) Affichez le nom du produit, le nom du fournisseur, le nom de la catégorie et les quantités de produits qui ne sont pas d'une des catégories 1, 3, 5 et 7 --
select produits.NOM_PRODUIT , fournisseurs.SOCIETE, categories.NOM_CATEGORIE, produits.QUANTITE, categories.CODE_CATEGORIE 
from produits
inner join fournisseurs on fournisseurs.NO_FOURNISSEUR = produits.NO_FOURNISSEUR 
inner join categories on categories.CODE_CATEGORIE = produits.CODE_CATEGORIE 
and categories.CODE_CATEGORIE not in (1, 3, 5, 7);

-- 21) Affichez le nom du produit, le nom du fournisseur, le nom de la catégorie et les quantités des produits qui ont le numéro fournisseur entre 1 et 3 
-- ou un code catégorie entre 1 et 3, et pour lesquelles les quantités sont données en boîtes ou en cartons.--
select produits.NOM_PRODUIT, fournisseurs.SOCIETE, categories.NOM_CATEGORIE, QUANTITE, categories.CODE_CATEGORIE, fournisseurs.NO_FOURNISSEUR
from produits
inner join fournisseurs on fournisseurs.NO_FOURNISSEUR = produits.NO_FOURNISSEUR 
inner join categories on categories.CODE_CATEGORIE  = produits.CODE_CATEGORIE 
where 
(fournisseurs.no_fournisseur between 1 and 3  or categories.CODE_CATEGORIE between 1 and 3) 

and 

(produits.quantite like '%carton%' or produits.QUANTITE  like '%boÃ®te%');

-- 22) Écrivez la requête qui permet d'afficher le nom des employés qui ont effectué au moins une vente pour un client parisien. --
select employes.NOM 
from employes
inner join commandes on commandes.NO_EMPLOYE = employes.NO_EMPLOYE 
inner join clients on clients.CODE_CLIENT = commandes.CODE_CLIENT
where ville = 'Paris';

-- 23) Affichez le nom des produits et le nom des fournisseurs pour les produits des catégories 1, 4 et 7. --
select produits.NOM_PRODUIT, fournisseurs.SOCIETE 
from produits
inner join fournisseurs on fournisseurs.NO_FOURNISSEUR = produits.NO_FOURNISSEUR   
where produits.CODE_CATEGORIE in (1, 4, 7);

-- 24) Affichez la liste des employés ainsi que le nom de leur supérieur hiérarchique. -- 
select E1.NOM as 'EMPLOYE', E2.NOM as'SUPERIEUR'
from employes  as E1
left join employes as E2 on E1.REND_COMPTE = E2.NO_EMPLOYE 
 
select E1.NOM as 'EMPLOYE', E2.NOM as'SUPERIEUR'
from employes  as E1, employes as E2
where E1.REND_COMPTE = E2.NO_EMPLOYE; 


-- 25) Affichez la somme des salaires et des commissions des employés. -- 
select sum(salaire) as 'total salaire', sum(ifnull(commission, 0)) as 'total commission' 
from employes 

-- 26) Affichez la moyenne des salaires et des commissions des employés --
select avg(salaire) as 'moyenne salaire', 
cast(avg(ifnull(commission,0)) as decimal(15,2)) as 'moyennne commission'
from employes

-- 27) Affichez le salaire maximum et la plus petite commission des employés -- 
select max(salaire), min(commission)
from employes 

-- 28) Affichez le nombre distinct de fonction. --
select count(distinct fonction) as 'nombre de fonction dans entreprise' 
from employes;


-- 29) Écrivez la requête qui permet d’afficher la masse salariale des employés par fonction -- 
select sum(salaire+ ifnull(COMMISSION, 0)) AS 'Masse salariale', fonction 
from employes 
group by FONCTION;
 
-- 30) Affichez le numéro de commande de celles qui comportent plus de 5 références de produit -- 
select NO_COMMANDE , count(REF_PRODUIT)
from details_commandes  
group by NO_COMMANDE 
having count(REF_PRODUIT) > 5;  

-- 31) Afficher la valeur des produits en stock et la valeur des produits commandés par fournisseur
-- pour les fournisseurs qui ont un numéro compris entre 3 et 6. -- 
select NO_FOURNISSEUR, 
sum(produits.PRIX_UNITAIRE * produits.UNITES_STOCK),
sum(produits.PRIX_UNITAIRE * produits.UNITES_COMMANDEES)
from produits 
where produits.NO_FOURNISSEUR between 3 and 6
group by produits.NO_FOURNISSEUR;

-- 32) Quelle date sera-t-il dans 3 mois ? -- 
select curdate() + interval 3 month 

-- 33) Affichez la société, adresse et ville de résidence pour tous les tiers de l’entreprise. -- 
select clients.SOCIETE, clients.ADRESSE, clients.VILLE 
from clients 
UNION
select fournisseurs.SOCIETE, fournisseurs.ADRESSE, fournisseurs.VILLE 
from fournisseurs 

 
-- 34) Affichez toutes les commandes qui comportent en même temps des produits de catégorie 1 du fournisseur 1 et des produits de catégorie 2 du fournisseur 2.
SELECT details_commandes.NO_COMMANDE
FROM details_commandes
inner join produits on details_commandes.REF_PRODUIT = produits.REF_PRODUIT 
	AND produits.NO_FOURNISSEUR = 1 
    AND produits.CODE_CATEGORIE = 1
WHERE EXISTS (
	SELECT *
	FROM details_commandes AS dc
	inner join produits p on dc.REF_PRODUIT = p.REF_PRODUIT
		AND p.NO_FOURNISSEUR = 2 
		AND p.CODE_CATEGORIE = 2
	WHERE dc.NO_COMMANDE = details_commandes.NO_COMMANDE
);


-- 35) Affichez la liste des produits que les clients parisiens ne commandent pas
select *
from produits 
where not exists (
	select * 
	from details_commandes 
	inner join commandes on commandes.NO_COMMANDE = details_commandes.NO_COMMANDE 
	inner join clients on clients.CODE_CLIENT = commandes.CODE_CLIENT 
	where clients.VILLE = 'Paris'
	and produits.REF_PRODUIT = details_commandes.REF_PRODUIT);

-- 36) Affichez tous les produits pour lesquels la quantité en stock est inférieur à la moyenne des quantités en stock. --
select *
from produits 
where UNITES_STOCK < (
	select avg(UNITES_STOCK) 
	from produits);

-- 37)Affichez toutes les commandes pour lesquelles 
-- les frais de ports dépassent la moyenne des frais de ports pour ce client
select * 
from commandes
where port > (
	select avg(port)
	from commandes as con 
	where con.CODE_CLIENT = commandes.CODE_CLIENT); 

-- 38) Affichez les produits pour lesquels la quantité en stock est supérieure 
-- à la quantité en stock de chacun des produits de catégorie 3. 
select *
from produits
where UNITES_STOCK > 
	ALL(select UNITES_STOCK 
	from produits 
	where CODE_CATEGORIE = 3);


-- 39) Affichez les produits, fournisseurs et unités en stock pour --
-- les produits qui ont un stock inférieur à la moyenne des stocks des produits pour le même fournisseur.-- 
select produits.NOM_PRODUIT, fournisseurs.SOCIETE, produits.UNITES_STOCK 
from produits 
inner join fournisseurs on fournisseurs.NO_FOURNISSEUR = produits.NO_FOURNISSEUR 
where UNITES_STOCK < (select avg(UNITES_STOCK) from produits as p where p.NO_FOURNISSEUR = produits.NO_FOURNISSEUR); 

-- 40) Affichez les employés avec leur salaire et le % par rapport au total de la masse salariale par fonction.
SELECT employes.NOM, concat(round((salaire/masse.sal)*100), ' %')
from employes, (select fonction, sum(salaire) AS sal from employes group by FONCTION) as masse
where employes.FONCTION = masse.fonction;

-- 41) Insérer une nouvelle catégorie de produits nommée "fruits et légumes", en respectant la contrainte 

INSERT INTO categories (CODE_CATEGORIE , NOM_CATEGORIE , DESCRIPTION ) 
VALUES (9, 'fruits et légumes', 'fruits et légumes')

INSERT INTO categories  
select max("CODE_CATEGORIE")+1, 'NOM de la catégorie', 'DESCRIPTION'
from categories ; 

select * 
from categories c 

-- 42) Créer un nouveau fournisseur "Grandma" (NO_FOURNISSEUR = 30) avec les mêmes coordonnées que le fournisseur
-- "Grandma Kelly's Homestead."

insert into fournisseurs(NO_FOURNISSEUR, SOCIETE, ADRESSE, VILLE, CODE_POSTAL, PAYS, TELEPHONE, FAX)
select 30, 'Grandma', ADRESSE, VILLE, CODE_POSTAL, PAYS, TELEPHONE, FAX
from fournisseurs 
where SOCIETE = 'Grandma Kelly''s Homestead';

select * 
from fournisseurs f 

-- 43) Attribuer les produits de "Grandma Kelly's Homestead" au nouveau fournisseur créé "Grandma"

UPDATE produits
SET NO_FOURNISSEUR = 30 
WHERE NO_FOURNISSEUR = 3

select * from produits where NO_FOURNISSEUR ='30'

-- 44) Supprimez l'ancien fournisseur "Grandma Kelly's Homestead"
DELETE FROM fournisseurs
WHERE SOCIETE = 'Grandma Kelly''s Homestead'

select * 
from fournisseurs f 

DELETE FROM fournisseurs
WHERE NO_FOURNISSEUR = '3'



-- 45) Créez une table pays avec 2 champs : code pays (4 caractères, clé primaire), nom pays (40 caractères maximum) 
create table PAYS (
	CODE_PAYS VARCHAR(4) not null primary key, 
	NOM_PAYS VARCHAR(40) not null
);


-- 46) Ajoutez une colonne courriel (75 caractères possibles) à la table CLIENTS. 
-- Puis modifiez la pour passer à 60 caractères. Pour finir, supprimez cette colonne.

ALTER table clients 
ADD clients.EMAIL VARCHAR(75) 
 
ALTER table clients
MODIFY clients.EMAIL VARCHAR (60)

alter table clients 
DROP COLUMN clients.EMAIL

select * 
from clients


-- 47) Créez une vue qui affiche le nom de la société, l’adresse, le téléphone et 
-- la ville des clients qui habitent à Toulouse, Strasbourg, Nantes ou Marseille. 
CREATE VIEW vue AS 
SELECT * 
FROM clients
WHERE VILLE = 'Toulouse' or ville ='Strasbourg' or ville = 'Nantes' or ville = 'Marseille' ; 

select * 
from vue 

