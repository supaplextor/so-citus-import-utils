#!/usr/bin/env python

import xml.etree.cElementTree as ElementTree
import os
import sys
import re

db = "so"
encoding = "UTF-8"

def escape(str):
    str = re.sub("\s", " ", str)
    # \ are special for Python strings *and* for regexps. Hence the
    # multiple escaping. Here,we just replace every \ by \\ for
    # PostgreSQL
    str = re.sub("\\\\", "\\\\\\\\", str)
    return str

postHistory = ElementTree.iterparse(sys.stdin) 
print "COPY posthistory (id, type, postid, revisionguid, creation, userid, userdisplaymame, text) FROM stdin;"

for event, post in postHistory:
    if event == "end" and post.tag == "row":
        id = int(post.attrib["Id"])

        type = int(post.attrib["PostHistoryTypeId"])

        postid = int(post.attrib["PostId"])

        revisionguid = post.attrib["RevisionGUID"]

        creation = post.attrib["CreationDate"]

        if post.attrib.has_key("UserId"):
            userid = post.attrib["UserId"]
        else:
            userid = "\N"

        if post.attrib.has_key("UserDisplayName"):
            userdisplaymame = escape(post.attrib["UserDisplayName"])
        else:
            userdisplaymame = "\N"

        if post.attrib.has_key("Text"):
            text = escape(post.attrib["Text"])
        else:
            text = "\N"

        print "%i\t%s\t%s\t%s\t%s\t%s\t%s\t%s" % (id, type, postid, revisionguid, creation, userid, userdisplaymame.encode(encoding), text.encode(encoding))
        post.clear()
    
print "\."

