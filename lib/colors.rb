### Provides coloration and enhancement methods for output strings ###

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def yellow;         "\e[33m#{self}\e[0m" end
  def white;          "\e[37m#{self}\e[0m" end

  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def underline;      "\e[4m#{self}\e[24m" end
end
