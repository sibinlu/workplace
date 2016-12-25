#
# Makefile
#
#

######################

DICT_NAME		=	"New Oxford American Dictionary"
DICT_SOURCE_DIR=dict
DICT_DEV_KIT_OBJ_DIR=./objects

DATA_FAKE_RAW=data.txt
DICT_SRC_PATH=$(DICT_SOURCE_DIR)/NOAD.xml
DATA_FAKE_WORDLIST=$(DICT_DEV_KIT_OBJ_DIR)/NOAD_wotd_list.txt

DESTINATION_DICT_FOLDER	=	/Library/Dictionaries
DESTINATION_DATA_FILE = "/System/Library/Graphics/Quartz Composer Plug-Ins/WOTD.plugin/Contents/Resources/NOAD_wotd_list.txt"

#####################
all:  fakedata fakedict
	
fakedata:
	@echo "####################"
	@echo "Building the Fake Data"
	mkdir -p $(DICT_DEV_KIT_OBJ_DIR)
	./build_data.sh $(DATA_FAKE_RAW) $(DATA_FAKE_WORDLIST) $(DICT_SRC_PATH)

fakedict:
	@echo "####################"
	@echo "Building the Fake Dict"
	make -C $(DICT_SOURCE_DIR)/ all
	ditto --noextattr --norsrc $(DICT_SOURCE_DIR)/$(DICT_DEV_KIT_OBJ_DIR)/$(DICT_NAME).dictionary  $(DICT_DEV_KIT_OBJ_DIR)/$(DICT_NAME).dictionary

install: install_dict install_data

install_dict:
	@echo "####################"
	./install_dict.sh $(DICT_DEV_KIT_OBJ_DIR)/$(DICT_NAME).dictionary $(DICT_NAME).dictionary 

install_data:
	@echo "####################"
	./install_data.sh $(DATA_FAKE_WORDLIST) $(DESTINATION_DATA_FILE)


clean:
	make -C $(DICT_SOURCE_DIR)/ clean
	$(RM) -rf $(DICT_DEV_KIT_OBJ_DIR)
