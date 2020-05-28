from django.views.generic import TemplateView

from main.helper import MapBuilder
from django.template import engines


class IndexView(TemplateView):

    def render_to_response(self, context, **response_kwargs):
        response_kwargs.setdefault('content_type', self.content_type)
        django_engine = engines['django']
        _map = MapBuilder()
        template = django_engine.from_string(_map.html)
        response_kwargs.setdefault('content_type', self.content_type)
        return self.response_class(
            request=self.request,
            template=template,
            context=context,
            using=self.template_engine,
            **response_kwargs
        )
