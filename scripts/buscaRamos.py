#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Credits isseu
import urllib2
import re
from titlecase import titlecase

cursos = []
data = urllib2.urlopen("http://catalogo.uc.cl/index.php?Itemid=55").read().replace("\n", "")
tabla = re.findall('<tr>.+?</tr>', data, flags=re.MULTILINE)

for item in tabla:
	res = re.search("<td>(.+?)</td><td>(.+?)</td><td>(.+?)</td>", item, flags=re.MULTILINE)
	if not res == None:
		sigla_seccion = res.group(2).split("-")
		if sigla_seccion[0] not in [i[1] for i in cursos]:
			cursos.append([res.group(1), sigla_seccion[0], res.group(3)])

print "# Encontrados " + str(len(cursos)) + " cursos: "
for item in cursos:
	print "Curso.create!(nombre: \"%s\", sigla: \"%s\")" % (item[2], item[1])


