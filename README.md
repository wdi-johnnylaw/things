1. Generate the Opinion model with references to user and thing, and also give it a comment(text) field and a rating(integer) field

2. Run the migrations

3. Set up the relationships between User and Opinion, Opinion and User, Opinion and Thing, Thing and Opinion, User and Thing

4. Uncomment the seeds file and run rake db:seed

5. Add the opinions list to the things/show.html.erb.  We did this by making a partial opinions/_opinion.html.erb, although you could add it in the view directly.

6. Add the form; use the helper provided in opinions_helper.rb

7. Add the average rating method to the Thing model

8. Add a display of the average rating on the thing show page