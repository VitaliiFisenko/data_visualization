import os

import requests
from bs4 import BeautifulSoup

from main.models import DataModel


class MapBuilder:
    def __init__(self):
        self.html = self.__get_map()

    def __get_map(self):
        resp = requests.get(os.getenv('DATA_URL'))
        obj = DataModel.objects.last()
        if not obj:
            obj = DataModel.objects.create(data=resp.text)
        html = self.__prepare_text(obj.data)
        return html

    def __prepare_text(self, html):
        soup = BeautifulSoup(html, features="html.parser")
        soup.body.div.div.decompose()
        pane = soup.body.div.find(id='RightPane')
        pane.find(id='basemapGallery').decompose()
        pane.find(id='print_button').decompose()
        return soup.html
