## Creation de GPO puis gestion droit panneau de configuration

- Aller dans tools, puis Group Policy Management;

- Ensuite On déroule la forêt concerné, puis lorsque l'on voit le groupe que l'on veut modifier (Wilders_students dans l'exo) on clique droit dessus et : `Create a GPO in this domain, and Link it here`;

- On donne un nom à notre GPO (Wilders dans l'exo) et on clique sur `OK`;

- Une fois le GPO créé, on clique droit dessus et `edit`;

- Dans User Configuration on va dans `policies`, puis `administrative Templates` et enfin `Control Panel`;

- On double clique sur `Prohibit access to Control Panel and PC setting`;

- Une fois là on met sur `disabled`puis on clique sur `apply`puis sur `OK`;

- Maintenant que tout est OK on peut fermer les fenêtres.