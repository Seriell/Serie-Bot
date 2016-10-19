import textgen
import sys
import codecs
import json
import os
import random
import re

os.chdir(os.path.dirname(os.path.realpath(__file__)))
user_re = re.compile("^[A-Za-z0-9_|.\-\]\[\{\}]*$", re.I)

def is_valid(target):
    """ Checks if a string is a valid IRC user. """
    if user_re.match(target):
        return True
    else:
        return False


def is_self(conn, target):
    """ Checks if a string is "****self" or contains conn.name. """
    if re.search("(^..?.?.?self|{})".format(re.escape(conn.user)), target, re.I):
        return True
    else:
        return False


def load_attacks(user, command):
    with codecs.open("larts.txt", encoding="utf-8") as f:
        larts = [line.strip() for line in f.readlines() if not line.startswith("//")]

    with codecs.open("flirts.txt", encoding="utf-8") as f:
        flirts = [line.strip() for line in f.readlines() if not line.startswith("//")]

    with codecs.open("insults.txt", encoding="utf-8") as f:
        insults = [line.strip() for line in f.readlines() if not line.startswith("//")]

    with codecs.open("kills.json", encoding="utf-8") as f:
        kills = json.load(f)

    with codecs.open("slaps.json", encoding="utf-8") as f:
        slaps = json.load(f)
        
    with codecs.open("strax.json", encoding="utf-8") as f:
        straxs = json.load(f)

    with codecs.open("compliments.json", encoding="utf-8") as f:
        compliments = json.load(f)

    with codecs.open("north_korea.txt", encoding="utf-8") as f:
        north_korea = [line.strip() for line in f.readlines() if not line.startswith("//")]
        
    with codecs.open("presents.json", encoding="utf-8") as f:
        presents = json.load(f)
        
    commands = {
		"larts": lart(user, larts),
		"insult": insult(user, insults),
		"kill": kill(user, kills),
		"slap": slap(user, slaps),
		"compliment": compliment(user, compliments),
		"nk": nk(north_korea),
		"strax": strax(user, straxs),
		"flirt": flirt(user, flirts),
		"present": present(user, presents)
	}
	
    try:
        actions = commands[command]
        print("*" + actions + "*")
    except:
        print("*Not a valid actions command.*")
        sys.exit(1)	


def lart(user, larts):
    phrase = random.choice(larts)

    # act out the message
    string = phrase.format(user=user)
    return string


def flirt(user, flirts):
    string = '{}, {}'.format(user, random.choice(flirts))
    return string


def kill(user, kills):
    generator = textgen.TextGenerator(kills["templates"], kills["parts"], variables={"user": user})

    string = generator.generate_string()
    return string


def slap(user, slaps):
    variables = {
        "user": user
    }
    generator = textgen.TextGenerator(slaps["templates"], slaps["parts"], variables=variables)

    string = generator.generate_string()
    return string


def compliment(user, compliments):
    variables = {
        "user": user
    }
    generator = textgen.TextGenerator(compliments["templates"], compliments["parts"], variables=variables)

    string = generator.generate_string()
    return string
    
def strax(user, straxs):
    variables = {
       "user": user
    }

    generator = textgen.TextGenerator(straxs["target_template"], straxs["parts"], variables=variables)

    string = generator.generate_string()
    return string

def nk(north_korea):
    index = random.randint(0,len(north_korea)-1)
    slogan = north_korea[index]
    return slogan

def insult(user, insults):
    string = "{}, {}".format(user, random.choice(insults))
    return string
    
def present(user, presents):
    variables = {
       "user": user
    } 
    
    generator = textgen.TextGenerator(presents["templates"], presents["parts"], variables=variables) 
    string = generator.generate_string()
    return string
    
def main():
	user = sys.argv[1]
	command = sys.argv[2]
	
	load_attacks(user, command)
	
main()
