import fabric # importing the base package
from fabric import Application
from fabric.widgets.label import Label   # gets the Label class
from fabric.widgets.window import Window  # grabs the Window class from Fabric
from fabric.widgets.datetime import DateTime
from fabric.utils import get_relative_path, monitor_file
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.x11 import X11Window as Window


class StatusBar(Window):
    def __init__(self, **kwargs):
        super().__init__(
            layer="top",  # Ensure it stays above other apps
            geometry="top",
            type_hint="dock",
            **kwargs
        )
        self.date_time = DateTime()
        self.children = CenterBox(
            name="my-box",
            center_children=self.date_time
        )


if __name__ == "__main__":
    bar = StatusBar()
    app = Application("bar", bar)

    def apply_stylesheet(*_):
        return app.set_stylesheet_from_file(
            get_relative_path("./styles/style.css")
        )
    style_monitor = monitor_file(get_relative_path("./styles"))
    style_monitor.connect("changed", apply_stylesheet)
    apply_stylesheet() # initial styling
    app.run()
