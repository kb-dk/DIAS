# ClientSideValidations Initializer

# Uncomment to disable uniqueness validator, possible security issue
# ClientSideValidations::Config.disabled_validators = [:uniqueness]

# Uncomment the following block if you want each input field to have the validation messages attached.

=begin
 ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
   unless html_tag =~ /^<label/
     #%(<div class="control-group error">#{html_tag}<span class="help-inline">#{instance.error_message.first}</span></div>).html_safe
     #%(<div class="control-group error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
     %{<div class="field_with_errors">#{html_tag}<span class="help-inline"><label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</span></label></div>}.html_safe
   else
     %(<div class="control-group error">#{html_tag}<span class="help-inline">B &nbsp; #{instance.error_message}</span></div>).html_safe
     #%{<div class="field_with_errors help-inline">#{html_tag}</div>}.html_safe
   end
 end
=end

 ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
   unless html_tag =~ /^<label/
     %{<div class="field_with_errors"><div class="control-group error">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message help-inline">#{instance.error_message.first}</label></div></div>}.html_safe
   else
     %{<div class="field_with_errors"><div class="control-group error">#{html_tag}</div></div>}.html_safe
   end
 end






=begin
 ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
   logger.info("beskeder")
   html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
   # add nokogiri gem to Gemfile

   form_fields = [
       'textarea',
       'input',
       'select'
   ]

   elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

   elements.each do |e|
     if e.node_name.eql? 'label'
       html = %(<div class="control-group error">#{e}</div>).html_safe
     elsif form_fields.include? e.node_name
       if instance.error_message.kind_of?(Array)
         html = %(<div class="control-group error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe

       else
         html = %(<div class="control-group error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
       end
     end
   end
   html
 end
=end