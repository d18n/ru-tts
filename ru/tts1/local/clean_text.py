#!/user/bin/env python3
import os
import argparse
import codecs
from pathlib import Path

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("in_text", type=str, help="text to be cleaned")
    parser.add_argument("out_text", type=str, help="text to be cleaned")
    
    args = parser.parse_args()
    with codecs.open(args.in_text, "r", "utf-8") as f_in, codecs.open(args.out_text, "w", "utf-8") as f_out:
        for line in f_in.readlines():
            id, content, _, duration = line.split("|")
            id = Path(id).stem
            # for now, I don't think we'll need to clean anything, but if we ever want to someday use the regular latin alphabet instead of cyrillic, it can be implemented here
            f_out.write("%s %s\n" % (id, content))