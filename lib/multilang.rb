module Multilang
  def block_code(code, full_lang_name)
    if full_lang_name
      # Split language name and handle cases like `javascript--tab1`
      parts = full_lang_name.split('--')
      rouge_lang_name = (parts) ? parts[0] : "" # just parts[0] here causes null ref exception when no language specified
      tab_class = "tab-#{full_lang_name}" # Additional custom class

      # Parse growthdocs-slug=<slug> from the code block
      growthdocs_slug = code.match(/growthdocs-slug=(.+)/)&.captures&.first

      clock_block = super(code, rouge_lang_name).sub("highlight #{rouge_lang_name}") do |match|
        match + " tab-" + full_lang_name
      end

      if growthdocs_slug
        code_block = clock_block.sub(/<code.*?>.*?<\/code>/m, "<div growthdocs-slug=\"#{growthdocs_slug}\"></div>")
      end

      puts "code_block: #{code_block}"

      code_block
    else
      super(code, full_lang_name)
    end
  end
end

require 'middleman-core/renderers/redcarpet'
Middleman::Renderers::MiddlemanRedcarpetHTML.send :include, Multilang