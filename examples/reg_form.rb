require 'rubygems'
require '../lib/pdf_filler'
require 'ruby-debug'
require 'pp'

template_file = 'RegFormTemplate.pdf'
reg_form = PDFPage(template_file)     # Same as RenoRB::PDF::Page.new(template_file)


# Demo 1  :  Show fields and the possible fields states
##################################################
#debugger ; a=1
all_fields = reg_form.get_pdf_fields
pp all_fields



#debugger ; a=2
field_name = 'Race' # Options
field_states = reg_form.get_field_states(field_name)
pp field_states


# debugger ; a=3
reg_form.set_radio_button(field_name, field_states.first)

reg_form.save_to('reg_form_filled1.pdf')




# Demo 2  :  Fill the PDF
##################################################

field_name = 'Registrant Type' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Team Adult Advisor')])  # Team Adult Advisor

reg_form.set_text_field('First Name', 'Wesley')
reg_form.set_text_field('Last Name', 'Hays')
reg_form.set_text_field('Team Name', 'UNR - CASAT Team')
reg_form.set_text_field('Title', 'IT Manager / Web Developer / Systems Administrator')
reg_form.set_text_field('Agency Organization', 'Center for the Application of Substance Abuse Technologies')
reg_form.set_text_field('Mailing Address', '800 Haskell St.')
reg_form.set_text_field('City', 'Reno')
reg_form.set_text_field('State', 'NV')
reg_form.set_text_field('Zip', '89509')
reg_form.set_text_field('Email', 'whays@casat.org')
reg_form.set_text_field('Fax Area Code', '775')
reg_form.set_text_field('Fax Number', '784-1840')
reg_form.set_text_field('Phone Area Code', '775')
reg_form.set_text_field('Phone Number', '784-1174')
reg_form.set_text_field('Special Accommodations 1', 'Vegetarian meals')


field_name = 'Race' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('White / European American')])  # "White / European American"

field_name = 'Ethnicity' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Non-Hispanic')])  # Non-Hispanic

field_name = 'Gender' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Male')])  # Male

field_name = 'Age' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('26-55')])  # 26-55

field_name = 'T-Shrit Size' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('M')])  # M

field_name = 'Employer' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('State / Public Agency')])  # State / Public Agency

field_name = 'Prevention Summits Attended' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('2-4')])  # 2-4

reg_form.set_checkbox('_hac_ Save the Date flyer', 'Yes')   # Save the Date flyer
reg_form.set_checkbox('_hac_ CASAT Website', 'Yes')         # CASAT Website
reg_form.set_checkbox('_hac_ Other', 'Yes')                 # Other
reg_form.set_text_field('_hac_ Other Text', 'School Flyer') # Other field

field_name = 'Prevention Professionals Reception' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Yes')])  # Yes

field_name = 'E-Briefs' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Yes')])  # Yes

field_name = 'Receive Future Information' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('E-mail')])  # E-mail

field_name = 'Team Formed' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('2-4 years')])  # 2-4 years

field_name = 'Team Attended Prevention Summit' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Yes')])  # Yes

field_name = 'Team Accomplished Past Projects' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Yes')])  # Yes

field_name = 'Team Experience Completing Past Projects' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('3')])  # 3

# Agree to the two team advisor questions
reg_form.set_checkbox('Team Advisor Q1', 'Yes')   
reg_form.set_checkbox('Team Advisor Q2', 'Yes')

reg_form.set_text_field('Youth1 Name', 'Nicklaus Hays')
reg_form.set_text_field('Youth1 Phone', '775-111-1111')

reg_form.set_text_field('Youth2 Name', 'Benjamin Hays')
reg_form.set_text_field('Youth2 Phone', '775-222-2222')

# Agree to the two registrant questions
reg_form.set_checkbox('Registrant Q1', 'Yes')   
reg_form.set_checkbox('Registrant Q2', 'Yes')

field_name = 'Registration' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Early')])  # Early Registration

reg_form.set_checkbox('Cancellation Policy', 'Yes')  # Cancellation Policy

field_name = 'Payment Options' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('Credit Card')])  # Credit Card

field_name = 'Credit Cards' # Options Group
field_states = reg_form.get_field_states(field_name)
reg_form.set_radio_button(field_name, field_states[field_states.index('VISA')])  # VISA

reg_form.set_text_field('Card Number', '4111-1111-1111-1111')
reg_form.set_text_field('Card Code', '214')
reg_form.set_text_field('Card Exp Date', '07/11')
reg_form.set_text_field('Card Amount', '125')
reg_form.set_text_field('Card Name', 'University of Nevada Reno')
reg_form.set_text_field('Agency Tax ID', '123456789')


reg_form.set_checkbox('Photo Video Question', 'Yes')                
reg_form.set_text_field('Agreement Date', '8/24/09')
reg_form.set_text_field('Agreement Participant Name', 'Wesley Hays')



reg_form.save_to('reg_form_filled2.pdf')
