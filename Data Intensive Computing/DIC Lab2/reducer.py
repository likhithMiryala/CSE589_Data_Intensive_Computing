#!/usr/bin/env python
"""reducer.py"""

from operator import itemgetter
import sys

current_word = None
current_count = 0
word = None
dic = {}

searchTerm = 'WhiteHouse'

# input comes from STDIN
for line in sys.stdin:
    line = line.strip()

    word, count = line.split('\t', 1)

    try:
        count = int(count)
    except ValueError:
        continue

    if current_word == word:
        current_count += count
    else:
        if current_word:
            dic[current_word] = int(current_count)
        current_count = count
        current_word = word

if current_word == word:
    #print '%s\t%s' % (current_word, current_count)
    dic[current_word] = int(current_count)

i = 0
myfile = open(searchTerm + "_NYT.tsv", "a")
myfile.write("%s\t%s\n" % ("word", "count"))
for key, value in sorted(dic.iteritems(), key=lambda (k,v): (v,k), reverse=True):
    if i < 100:
        myfile.write("%s\t%s\n" % (key, value))
        i += 1

