function savefig(h, filename)
    if ~ exist("../graphic", "dir")
        mkdir ../graphic
    end
    saveas(h, sprintf("../graphic/%s.jpg", filename), "jpg");
end