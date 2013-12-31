module Conekta
  class ConektaObject < Hash
    attr_reader :id
    def initialize(id=nil)
      @values = Hash.new
      @id = id.to_s
    end
    def set_val(k,v)
      @values[k] = v
    end
    def unset_key(k)
      @values.delete(k)
    end
    def load_from(hash)
      hash.each do |k,v|
        if v.respond_to? :each and !v.instance_of?(ConektaObject)
          v = Conekta::Util.convert_to_conekta_object(v)
        end
        if self.instance_of?(ConektaObject)
          self[k] = v
        else
          self.class.send(:define_method, k.to_sym, Proc.new {v})
        end
        self.set_val(k,v)
      end
    end
    def to_s
      @values.inspect
    end
  end
end