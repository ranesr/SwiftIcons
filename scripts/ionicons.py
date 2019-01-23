#!/usr/bin/env python
import sys, json
from stringcase import camelcase, titlecase

def main(argv):
	if len(sys.argv) != 2:
		print('{} <ion-mainfest.json>' % (sys.argv[0]))
		sys.exit(2)
	
	mainfestPath = sys.argv[1]
	with open(mainfestPath, 'r') as mainfestFile:
		mainfest = json.loads(mainfestFile.read())
		names = []
		cases = []
		codePoints = []
		for icon in mainfest['icons']:
			names.append(r'"%s"' % titlecase(icon['name']).replace('Md ', 'Material ').replace('Ios ', 'iOS '))
			cases.append(camelcase(icon['name'].replace('-','_')))
			codePoints.append(r'"\u{%s}"' % (icon['code'][2:]))

		print(', '.join(names))
		print(', '.join(cases))
		print(', '.join(codePoints))

if __name__ == "__main__":
   main(sys.argv[1:])