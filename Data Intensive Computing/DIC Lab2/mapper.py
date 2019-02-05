#!/usr/bin/env python
"""mapper.py"""

import sys

searchTerm = 'NeverAgain'

i = 0

punctuations = '''|!()-[]{};:'"\,<>./?@#$%^&*_~'''
stopWords = set(['ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', 'about', 'once', 'during', 'out', 'very', 'having', 'with', 'they', 'own', 'an', 'be', 'some', 'for', 'do', 'its', 'yours', 'such', 'into', 'of', 'most', 
       'itself', 'other', 'off', 'is', 's', 'am', 'or', 'who', 'as', 'from', 'him', 'each', 'the', 'themselves', 'until', 
       'below', 'are', 'we', 'these', 'your', 'his', 'through', 'don', 'nor', 'me', 'were', 'her', 'more', 'himself', 'this',
       'down', 'should', 'our', 'their', 'while', 'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', 'no', 'when', 
       'at', 'any', 'before', 'them', 'same', 'and', 'been', 'have', 'in', 'will', 'on', 'does', 'yourselves', 'then', 
       'that', 'because', 'what', 'over', 'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', 'you', 'herself', 'has', 
       'just', 'where', 'too', 'only', 'myself', 'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', 'theirs',
       'my', 'against', 'a', 'by', 'doing', 'it', 'how', 'further', 'was', 'here', 'than', '3', '15', 've', 'AR', '1', '435', '443', '432', '10', '17', '00BC'])

stopWords.add('What')
stopWords.add('Why')
stopWords.add('Are')
stopWords.add('If')
stopWords.add('who')
stopWords.add('would')
stopWords.add('The')
stopWords.add('said')
stopWords.add('I')
stopWords.add('In')
stopWords.add('It')
stopWords.add('A')
stopWords.add('U')
stopWords.add('m')
stopWords.add('Advertisement')
stopWords.add('donxe2x80x99t')
stopWords.add('re')

for line in sys.stdin:
    i += 1

    noPunct = "" # Removing the punctuations
    
    for char in line:
        if char not in punctuations:
            noPunct = noPunct + char

    words = noPunct.split()  
    line1 = ""
    
    for r in words:
        if r[0:3] != "xe2" and r[0:3] != "xc2" and r[0:2] != "00" and r[0:2] != "ed" and r[0] != "x" and r[0:2] != "04":
            if (not r in stopWords):
                line1 += " " + r
                
    line1 = line1.strip()
    words = line1.split()
    for word in words:
        print '%s\t%s' % (word, 1)
