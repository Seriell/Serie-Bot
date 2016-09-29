import codecs
import json
import os
import random
import re
import sys
import textgen

os.chdir(os.path.dirname(os.path.realpath(__file__)))
nick_re = re.compile("^[A-Za-z0-9_|.\-\]\[\{\}\*]*$", re.I)

cakes = ['Chocolate', 'Ice Cream', 'Angel', 'Boston Cream', 'Birthday', 'Bundt', 'Carrot', 'Coffee', 'Devils', 'Fruit',
		 'Gingerbread', 'Pound', 'Red Velvet', 'Stack', 'Welsh', 'Yokan']

cookies = ['Chocolate Chip', 'Oatmeal', 'Sugar', 'Oatmeal Raisin', 'Macadamia Nut', 'Jam Thumbprint', 'Medican Wedding',
		   'Biscotti', 'Oatmeal Cranberry', 'Chocolate Fudge', 'Peanut Butter', 'Pumpkin', 'Lemon Bar',
		   'Chocolate Oatmeal Fudge', 'Toffee Peanut', 'Danish Sugar', 'Triple Chocolate', 'Oreo']

# <Luke> Hey guys, any good ideas for plugins?
# <Luke> BRILLIANT
potatoes = ['AC Belmont', 'AC Blue Pride', 'AC Brador', 'AC Chaleur', 'AC Domino', 'AC Dubuc', 'AC Glacier Chip',
			'AC Maple Gold', 'AC Novachip', 'AC Peregrine Red', 'AC Ptarmigan', 'AC Red Island', 'AC Saguenor',
			'AC Stampede Russet', 'AC Sunbury', 'Abeille', 'Abnaki', 'Acadia', 'Acadia Russet', 'Accent',
			'Adirondack Blue', 'Adirondack Red', 'Adora', 'Agria', 'All Blue', 'All Red', 'Alpha', 'Alta Russet',
			'Alturas Russet', 'Amandine', 'Amisk', 'Andover', 'Anoka', 'Anson', 'Aquilon', 'Arran Consul', 'Asterix',
			'Atlantic', 'Austrian Crescent', 'Avalanche', 'Banana', 'Bannock Russet', 'Batoche', 'BeRus',
			'Belle De Fonteney', 'Belleisle', 'Bintje', 'Blossom', 'Blue Christie', 'Blue Mac', 'Brigus',
			'Brise du Nord', 'Butte', 'Butterfinger', 'Caesar', 'CalWhite', 'CalRed', 'Caribe', 'Carlingford',
			'Carlton', 'Carola', 'Cascade', 'Castile', 'Centennial Russet', 'Century Russet', 'Charlotte', 'Cherie',
			'Cherokee', 'Cherry Red', 'Chieftain', 'Chipeta', 'Coastal Russet', 'Colorado Rose', 'Concurrent',
			'Conestoga', 'Cowhorn', 'Crestone Russet', 'Crispin', 'Cupids', 'Daisy Gold', 'Dakota Pearl', 'Defender',
			'Delikat', 'Denali', 'Desiree', 'Divina', 'Dundrod', 'Durango Red', 'Early Rose', 'Elba', 'Envol',
			'Epicure', 'Eramosa', 'Estima', 'Eva', 'Fabula', 'Fambo', 'Fremont Russet', 'French Fingerling',
			'Frontier Russet', 'Fundy', 'Garnet Chile', 'Gem Russet', 'GemStar Russet', 'Gemchip', 'German Butterball',
			'Gigant', 'Goldrush', 'Granola', 'Green Mountain', 'Haida', 'Hertha', 'Hilite Russet', 'Huckleberry',
			'Hunter', 'Huron', 'IdaRose', 'Innovator', 'Irish Cobbler', 'Island Sunshine', 'Ivory Crisp',
			'Jacqueline Lee', 'Jemseg', 'Kanona', 'Katahdin', 'Kennebec', "Kerr's Pink", 'Keswick', 'Keuka Gold',
			'Keystone Russet', 'King Edward VII', 'Kipfel', 'Klamath Russet', 'Krantz', 'LaRatte', 'Lady Rosetta',
			'Latona', 'Lemhi Russet', 'Liberator', 'Lili', 'MaineChip', 'Marfona', 'Maris Bard', 'Maris Piper',
			'Matilda', 'Mazama', 'McIntyre', 'Michigan Purple', 'Millenium Russet', 'Mirton Pearl', 'Modoc', 'Mondial',
			'Monona', 'Morene', 'Morning Gold', 'Mouraska', 'Navan', 'Nicola', 'Nipigon', 'Niska', 'Nooksack',
			'NorValley', 'Norchip', 'Nordonna', 'Norgold Russet', 'Norking Russet', 'Norland', 'Norwis', 'Obelix',
			'Ozette', 'Peanut', 'Penta', 'Peribonka', 'Peruvian Purple', 'Pike', 'Pink Pearl', 'Prospect', 'Pungo',
			'Purple Majesty', 'Purple Viking', 'Ranger Russet', 'Reba', 'Red Cloud', 'Red Gold', 'Red La Soda',
			'Red Pontiac', 'Red Ruby', 'Red Thumb', 'Redsen', 'Rocket', 'Rose Finn Apple', 'Rose Gold', 'Roselys',
			'Rote Erstling', 'Ruby Crescent', 'Russet Burbank', 'Russet Legend', 'Russet Norkotah', 'Russet Nugget',
			'Russian Banana', 'Saginaw Gold', 'Sangre', 'Satina', 'Saxon', 'Sebago', 'Shepody', 'Sierra',
			'Silverton Russet', 'Simcoe', 'Snowden', 'Spunta', "St. John's", 'Summit Russet', 'Sunrise', 'Superior',
			'Symfonia', 'Tolaas', 'Trent', 'True Blue', 'Ulla', 'Umatilla Russet', 'Valisa', 'Van Gogh', 'Viking',
			'Wallowa Russet', 'Warba', 'Western Russet', 'White Rose', 'Willamette', 'Winema', 'Yellow Finn',
			'Yukon Gold']

def load_foods(user, command):
	with codecs.open(os.path.join("sandwich.json"), encoding="utf-8") as f:
		sandwich_data = json.load(f)

	with codecs.open(os.path.join("taco.json"), encoding="utf-8") as f:
		taco_data = json.load(f)
   
	with codecs.open(os.path.join("coffee.json"), encoding="utf-8") as f:
		coffee_data = json.load(f)

	with codecs.open(os.path.join("noodles.json"), encoding="utf-8") as f:
		noodles_data = json.load(f)

	with codecs.open(os.path.join("muffin.json"), encoding="utf-8") as f:
		muffin_data = json.load(f)

	with codecs.open(os.path.join("tea.json"), encoding="utf-8") as f:
		tea_data = json.load(f)

	with codecs.open(os.path.join("keto.json"), encoding="utf-8") as f:
		keto_data = json.load(f)
	
	with codecs.open(os.path.join("beer.json"), encoding="utf-8") as f:
		beer_data = json.load(f)

	with codecs.open(os.path.join("cheese.json"), encoding="utf-8") as f:
		cheese_data = json.load(f)

	with codecs.open(os.path.join("pancake.json"), encoding="utf-8") as f:
		pancake_data = json.load(f)

	with codecs.open(os.path.join("chicken.json"), encoding="utf-8") as f:
		chicken_data = json.load(f)
		
	with codecs.open(os.path.join("nugget.json"), encoding="utf-8") as f:
		nugget_data = json.load(f)
		
	with codecs.open(os.path.join("pie.json"), encoding="utf-8") as f:
		pie_data = json.load(f)
		
	with codecs.open(os.path.join("brekkie.json"), encoding="utf-8") as f:
		brekkie_data = json.load(f)

	with codecs.open(os.path.join("icecream.json"), encoding="utf-8") as f:
		icecream_data = json.load(f)

	with codecs.open(os.path.join("doobie.json"), encoding="utf-8") as f:
		doobie_data = json.load(f)

	with codecs.open(os.path.join("pizza.json"), encoding="utf-8") as f:
		pizza_data = json.load(f)
	
	with codecs.open(os.path.join("chocolate.json"), encoding="utf-8") as f:
		chocolate_data = json.load(f)

	with codecs.open(os.path.join("pasta.json"), encoding="utf-8") as f:
		pasta_data = json.load(f)
	
	with codecs.open(os.path.join("cereal.json"), encoding="utf-8") as f:
		cereal_data = json.load(f)

	commands = {
		"potato": potato(user),
		"cake": cake(user),
		"cookie": cookie(user),
		"sandwich": sandwich(user, sandwich_data),
		"taco": taco(user, taco_data),
		"coffee": coffee(user, coffee_data),
		"noodles": noodles(user, noodles_data),
		"muffin": muffin(user, muffin_data),
		"tea": tea(user, tea_data),
		"keto": keto(user, keto_data),
		"beer": beer(user, beer_data),
		"cheese": cheese(user, cheese_data),
		"pancake": pancake(user, pancake_data),
		"chicken": chicken(user, chicken_data),
		"nugget": nugget(user, nugget_data),
		"pie": pie(user, pie_data),
		"brekkie": brekkie(user, brekkie_data),
		"icecream": icecream(user, icecream_data),
		"doobie": doobie(user, doobie_data),
		"pizza": pizza(user, pizza_data),
		"chocolate": chocolate(user, chocolate_data),
		"pasta": pasta(user, pasta_data),
		"cereal": cereal(user, cereal_data),
	}
	
	try:
		food = commands[command]
		print("*" + food + "*")
	except:
		print("*Not a valid food command.*")
		sys.exit(1)	
		
def potato(user):
	potato_type = random.choice(potatoes)
	size = random.choice(['small', 'little', 'mid-sized', 'medium-sized', 'large', 'gigantic'])
	flavor = random.choice(['tasty', 'delectable', 'delicious', 'yummy', 'toothsome', 'scrumptious', 'luscious'])
	method = random.choice(['bakes', 'fries', 'boils', 'roasts'])
	side_dish = random.choice(['side salad', 'dollop of sour cream', 'piece of chicken', 'bowl of shredded bacon'])

	string = "{} a {} {} {} potato for {} and serves it with a small {}!".format(method, flavor, size, potato_type, user,
																			   side_dish)
	
	return string


def cake(user):
	cake_type = random.choice(cakes)
	size = random.choice(['small', 'little', 'mid-sized', 'medium-sized', 'large', 'gigantic'])
	flavor = random.choice(['tasty', 'delectable', 'delicious', 'yummy', 'toothsome', 'scrumptious', 'luscious'])
	method = random.choice(['makes', 'gives', 'gets', 'buys'])
	side_dish = random.choice(['glass of chocolate milk', 'bowl of ice cream', 'jar of cookies',
							   'side of chocolate sauce'])

	string = "{} {} a {} {} {} cake and serves it with a small {}!".format(method, user, flavor, size, cake_type,
																		 side_dish)
	
	return string


def cookie(user):


	cookie_type = random.choice(cookies)
	size = random.choice(['small', 'little', 'medium-sized', 'large', 'gigantic'])
	flavor = random.choice(['tasty', 'delectable', 'delicious', 'yummy', 'toothsome', 'scrumptious', 'luscious'])
	method = random.choice(['makes', 'gives', 'gets', 'buys'])
	side_dish = random.choice(['glass of milk', 'bowl of ice cream', 'bowl of chocolate sauce'])

	string = "{} {} a {} {} {} cookie and serves it with a {}!".format(method, user, flavor, size, cookie_type,
																	 side_dish)
	return string


def sandwich(user, sandwich_data):
	generator = textgen.TextGenerator(sandwich_data["templates"], sandwich_data["parts"],
									  variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def taco(user, taco_data):
	generator = textgen.TextGenerator(taco_data["templates"], taco_data["parts"],
									  variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def coffee(user, coffee_data):
	generator = textgen.TextGenerator(coffee_data["templates"], coffee_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string
	
def noodles(user, noodles_data):
	generator = textgen.TextGenerator(noodles_data["templates"], noodles_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string
	
def muffin(user, muffin_data):
	generator = textgen.TextGenerator(muffin_data["templates"], muffin_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string
	
def tea(user, tea_data):
	generator = textgen.TextGenerator(tea_data["templates"], tea_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string

def keto(user, keto_data):
	generator = textgen.TextGenerator(keto_data["templates"], keto_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string

def beer(user, beer_data):
	generator = textgen.TextGenerator(beer_data["templates"], beer_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string

def cheese(user, cheese_data):
	generator = textgen.TextGenerator(cheese_data["templates"], cheese_data["parts"],
									  variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string

def pancake(user, pancake_data):
	generator = textgen.TextGenerator(pancake_data["templates"], pancake_data["parts"],
									  variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def chicken(user, chicken_data):
	generator = textgen.TextGenerator(chicken_data["templates"], chicken_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string
	
def nugget(user, nugget_data):
	generator = textgen.TextGenerator(nugget_data["templates"], nugget_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string
	
def pie(user, pie_data):
	generator = textgen.TextGenerator(pie_data["templates"], pie_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def icecream(user, icecream_data):
	generator = textgen.TextGenerator(icecream_data["templates"], icecream_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string
	
def brekkie(user, brekkie_data):
	generator = textgen.TextGenerator(brekkie_data["templates"], brekkie_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def doobie(user, doobie_data):
	generator = textgen.TextGenerator(doobie_data["templates"], doobie_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def pizza(user, pizza_data):
	generator = textgen.TextGenerator(pizza_data["templates"], pizza_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string
   
def chocolate(user, chocolate_data):
	generator = textgen.TextGenerator(chocolate_data["templates"], chocolate_data["parts"], variables={"user": user})
	# act out the message
	string = generator.generate_string()
	return string

def pasta(user, pasta_data):
	generator = textgen.TextGenerator(pasta_data["templates"], pasta_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def cereal(user, cereal_data):
	generator = textgen.TextGenerator(cereal_data["templates"], cereal_data["parts"], variables={"user": user})

	# act out the message
	string = generator.generate_string()
	return string

def main():
	user = sys.argv[1]
	command = sys.argv[2]
	
	load_foods(user, command)
	
main()