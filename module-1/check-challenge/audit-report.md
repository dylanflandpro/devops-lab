# Audit

## Webapp global
- Bin besoin que de 700
- config => pas besoin de permission pour group et other
- data => permission 7 uniquement pour proprio et lecture seule pour group
- log => execution not needed
- tmp surement pour temporaire => uniquement read pour group et rien pour others et pas besoin d'execution


## bin
- backup.sh => trop de perm, il faut 750
- cleanup.sh => same
- start.sh => same

## config

- app.conf => 750
- credentials.json => 700 ? sauf si l'app en a besoin donc 740
- .env => pareil que credential

## data
- user.db => si l'app a besoin 760 sinon 700

## logs 

- access.log => 640 => pas besoin d'execution et côté group uniquement lecture

- error.log => 640 => pas de permission a la base mais il faut y avoir accès quand même, même restreint

## public
- les permissions sont correctes selon moi, de toute façon accessible généralement

## tmp

j'en ai parlé plus haut