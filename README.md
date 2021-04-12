# learn_dragon_ruby
Repo for learning DragonRuby GTK Toolkit

## How to Get Started on Linux

For Linux, one way to do it is to unzip DragonRuby into a common directory and then add that to your path. This will allow you to work on many different games using the same DragonRuby installation.

### Download and Install DragonRuby
Download dragonruby-linux-amd64 then run these commands.

```bash
mkdir ~/bin

unzip dragonruby-gtk-linux-amd64.zip

mv dragonruby-linux-amd64 ~/bin/dragonruby
```

### Update PATH to include DragonRuby
Add these lines to your shell config, like in .bashrc or whatever file you use.

```bash
if [ -d "$HOME/bin/dragonruby" ] ; then

 export PATH="$HOME/bin/dragonruby:$PATH"

fi
```

Run this command to update your current shell environment (if using bash):

```bash
source ~/.bashrc
```

### Set up Directory for New Game
Now you can create a new game by just creating a directory structure similar to this:

```bash
mkdir -p testy/app
vim testy/run.sh
```

Add these lines to run.sh

```bash
#!/usr/bin/env bash

dragonruby ./
```

Make run.sh executable:

```bash
chmod u+x run.sh
```

Now create main.rb in the app directory:

```bash
vim testy/app/main.rb
```

Put something like this just to test:

```ruby
# test game while learning DragonRuby

def tick args

  args.outputs.labels  << [640, 500, 'This is really cool!', 5, 1]

  args.outputs.sprites << [576, 280, 128, 101, 'dragonruby.png']

end
```

Once you have that done you can run run.sh:

```bash
./run.sh
```

and it will load the game you have in main.rb.

Update main.rb and the game will update in real time!

Hope this helps and have a good one!
