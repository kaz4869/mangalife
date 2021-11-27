module ApplicationHelper
    def newline(str)
        h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
    end
end
