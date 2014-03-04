# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Opinion.destroy_all
User.destroy_all
Thing.destroy_all

chief, zack, ivy, jules, shadow, cole, carmen, justincase, pattylarceny, contessa = ['chief', 'zack', 'ivy', 'jules', 'shadow', 'cole', 'carmen', 'justincase', 'pattylarceny', 'contessa'].map do |username|
  User.create(username: username)
end

vrp, lps, kmk, gps, ksl, ajam, hcld, ld, hmr, uwr, gsr, osm, hpj, twl, nvm, ffc, bd, cs, cpd = [
  ['Voice recorder pen', 'vrp.jpg', 'With USB 2.0 download capability, this voice-activated device offers up to 33 hours of crystal-clear, digital record-time (audio is stored in 256MB of flash memory) and its \'One Click\' recording feature makes it ideal for recording your own conversations by law enforcement, investigative journalists, attorneys, medical professionals, secretaries, business professionals, and others.'],
  ['Lock pick set', 'lps.jpg', 'This professional set comes complete with a variety of tempered stainless steel hooks, rakes, balls, diamonds, extractors, tension tools, and a zippered leather carrying case.  A free bonus is the book "Pin Tumbler Lock Picking".'],
  ['Key Mold Kit', 'kmk.jpg', 'One of the most unique tools available in today\'s locksmith industry.  This device can cast an exact image of a key.'],
  ['GPS real-time tracker', 'gps.gif', 'Miniature Asset/Person/Vehicle Tracker provides up to 10 days (at 1 hour per day) of real-time tracking on its built-in rechargeable Li-ion battery, which makes it ideal for surveillance, package tracking, pet tracking, Alzheimers patient tracking, child tracking, and other spy applications.'],
  ['Keystroke Logger', 'ksl.jpg', 'Captures all keystrokes on your PC and does not require software to install -- ideal for monitoring online activity for clandestine activity, or as a data backup device. Simply plug in to a USB port and the non-volatile 4MB memory stores approximately 2000 pages of typed text.'],
  ['Audio Jammer','ajam.jpg','Ensure the privacy of your room conversations by generating an adjustable audible random masking sound which desensitizes any nearby microphones or tape recorders.  It is effective against any microphone based eavesdropping device including tape recorders, RF transmitters, shotgun microphones, parabolic microphones, and even microwave or laser reflection surveillance devices.  Because the sound from the AJ-34 varies randomly in frequency and amplitude, it cannot be filtered which results in eavesdroppers hearing only a loud hissing noise.'],
  ['Hidden Camera Lens Detector','hcld.jpg','Allows you to visually detect and locate any hidden wireless or hardwired camera.  Contains six ultra-bright LED lights around the viewing port.  To detect and locate any hidden camera simply scan the room through the viewing port.  Any bright red dots are a reflection off the hidden camera\'s lens.'],
  ['Lektor Decoder','ld.jpg','Typewriter-sized decoding device used to decipher encrypted messages.'],
  ['Handheld Microfilm Reader','hmr.jpg','Peruse microfilm while you\'re on-the-go'],
  ['Q Branch Keychain','qbc.jpg','lock-picks that could open 90 percent of the world\'s locks, stun gas'],
  ['Underwater Rebreather','uwr.jpg','Although more difficult than breathing above ground, when swimming this device will allow you to extract oxygen dissolved into liquids.'],
  ['Glass Shattering Ring','gsr.jpg','Emits a hellatious burst of high frequency sound that is very likely to cause nearby glass to crumble.'],
  ['Omega Seamaster with Laser','osm.jpg','This sporty watch features a 6 watt laser which can cut through paper, thin wood, and sheets of ice.'],
  ['High-powered portable cell phone jammer','hpj.png','Compatible with UMTS / 3G / CDMA / GSM / PHS networks, this device interferes with normal operation of a cell phone.'],
  ['Through-the-wall listening device','twl.jpg','You will not believe the clarity of this microphone and once you have used one you will want to keep hold of it! They are not just restricted to listening through walls, they can be used for picking up the faintest sound through any solid matter.'],
  ['Night Vision Monocular','nvm.jpg','With a second-generation Russian Image Intensifier Tube and interchangeable 50mm lens, this device offers night vision in very low light and total darkness. A green LED next to the viewfinder indicates when the Image Intensifier Tube is switched on while a red LED indicates when the built-in IR illuminator is switched on.  Tactile, suregrip plastic bodyshell and, for extra protection, partial rubber armouring.'],
  ['Flexible fiber camera','ffc.jpg','Safely monitor a location without being detected. The small video camera can be slid under doors, into cracks or holes in a wall, providing a clear view inside a room.'],
  ['Bug Detector','bd.jpg','Locate electronic bugs, phone taps and both wired and wireless hidden cameras in a room or vehicle.'],
  ['Clue Spray','cs.jpg','Leaves an invisible film on any surface, which when touched, is transferred to a person’s hand or clothing. Looking for clues or a suspect? Unknown to the victim, the spray remains for up to five days, even if the hands, for example, are washed repeatedly. The spray can’t be seen by the naked eye, but shows up with a fluorescent glow under ultra-violet light'],
  ['GPS detector','cpd.png','Scan the surrounding area for common GSM, CDMA, WCDMA, and DCS frequencies, between 824 and 1980 MHz, reporting back to you exactly what it found through an LCD display on the front of the device. These GPS detection devices are anti-surveillance equipment at its finest! In a matter of minutes, you’ll know of any cell phones, GPS trackers, or hidden listening devices in your car, home or office.']
].map do |thing_info|
  Thing.create(name: thing_info.first, image_url: thing_info[1], description: thing_info[2])
end

# chief, zack, ivy, jules, shadow, cole, carmen, justincase, pattylarceny, contessa
# vrp, lps, kmk, gps, ksl, ajam, hcld, ld, hmr, uwr, gsr, osm, hpj, twl, nvm, ffc, bd, cs, cpd

Opinion.create([
  { user: zack, thing: ajam, comment: 'This thing is total bullshit!', rating: 2 },
  { user: pattylarceny, thing: ajam, comment: 'Justin Case was not able to hear our plans to catch Carmen when we used this jammer.  Very effective.', rating: 4 },
  { user: ivy, thing: ajam, comment: 'If I could own a hundred of these things, I would!', rating: 5 },
  { user: jules, thing: ajam, comment: 'I found the product so/so to be honest.', rating: 3 },
  { user: shadow, thing: ajam, comment: 'Well, it certainly is interesting...', rating: 3 },
  { user: pattylarceny, thing: gsr, comment: 'We were able to ditch Ivy in a museum by shattering what I thought was the impossible -- a thick sheet of bulletproof glass.', rating: 5 },
  { user: jules, thing: hmr, comment: 'Hardly clear when reading even standard size print.  Almost worthless.', rating: 2 },
  { user: shadow, thing: osm, comment: 'The laser in this thing is better than a larger and more expensive one that I got in a fake cigarette pack, but the thing quit working after 2 months of use.  I\'m torn.', rating: 3 }
])