module Configuration

 #Initializing the configuration module
 def configuration
   yield self
 end

 #Method to define configuration variables & assign default values or values provied.
 def define_setting(name, default = nil)
   class_variable_set("@@#{name}", default)
   define_class_method "#{name}=" do |value|
     class_variable_set("@@#{name}", value)
   end
   define_class_method name do
     class_variable_get("@@#{name}")
   end
 end

 private

   #Method provides valid definition for class type of variables.
   def define_class_method(name, &block)
     (class << self; self; end).instance_eval do
       define_method name, &block
     end
   end

end