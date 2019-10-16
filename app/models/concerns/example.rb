module Example
  extend ActiveSupport::Concern

  class_methods do
    def foo; puts 'foo'; end

    private
      def bar; puts 'bar'; end
  end
end
