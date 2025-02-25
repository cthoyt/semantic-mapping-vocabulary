ONTBASE=http://w3id.org/semapv
ROBOT=robot -vvv

all: semapv.owl

semapv-terms.owl: semapv-terms.tsv
	$(ROBOT) template --template $< --prefix "skos: http://www.w3.org/2004/02/skos/core#" --prefix "semapv: http://w3id.org/semapv/vocab/" \
		annotate --ontology-iri $(ONTBASE)/vocab -o $@

SEMAPV_TERMS_URL=https://docs.google.com/spreadsheets/d/e/2PACX-1vQS6dVyRqEdXCtimXw1nxX77NCmJCfm_2sOL0eCkt_7MlTt8wCNgE8iw9pLACPIuwZDvu64WtsqtREQ/pub?gid=0&single=true&output=tsv

semapv-terms.tsv:
	wget "$(SEMAPV_TERMS_URL)" -O $@

semapv.owl: semapv-metadata.owl semapv-terms.owl
	$(ROBOT) merge -i semapv-metadata.owl -i semapv-terms.owl -o $@

