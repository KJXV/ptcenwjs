# PTCENW.js

*When you automate a mess, you get an automated mess.*

This is home to the engine that runs [Popcorn Time Community
Edition](http://popcorntimece.ch/)!

The goal of this repository is simply to make it easy to build the customised
NW.js package that Popcorn Time runs on. This repository lets you bypass all of
the bullshit associated with building Chromium. You only have to interact with
good things like git and sh!

## How is this any different than vanilla NW.js?

For a reason unknown to me, NW.js does not support useful codecs (such as
H.264), nor useful extentions (like .flac). These scripts automate the buliding
of an NW.js binary with useful codec and demux support. These scripts are
currently available for Linux amd64, Linux ia32.
Hopefully there will eventually be a scipt to build NW.js for ARMv7, but
unfortunately Roger Wang has *absolutely no interest what-so-ever* in porting
NW.js to ARM officially. So, for now, this isn't readily possible.

This is a fork of NW.js v12. It is frozen at that branch mostly because that is
what version it was on when I first started working on it. There's not a
compelling reason to patch it to a newer version yet as Popcorn Time Community
Edition doesn't use any of the features (or "features") implimented in versions
after 12.

This project is organised as such:
```
kjthegod/ptcenwjs {
	kjthegod/breakpad
	kjthegod/chromium {
		kjthegod/ffmpeg
	}
	kjthegod/node
	kjthegod/nw.js
	kjthegod/v8
	kjthegod/WebKit
}
```

There are obviously way more sub-projects, but these are the ones I'm interested
in, specifically ffmpeg.

## Why automate the build process?

*"Why automate the build process when there is perfectly good documentation on
both [Chromium](http://chromium.org/developers/how-tos/) and
[NW.js](http://github.com/nwjs/nw.js/wiki/)?"*

Because that documentation sucks ass. There is not perfectly good documentation.
It's wholesomely awful. Navigating Chromium's documentation is exactly like
navigating its source code: you have no idea what is going on. As for NW.js'
documentation, well, it's *always* out-dated because "fuck you. Download our
binaries".

I'm rebuilding this trash quite a lot. Or at least I plan to be. I might as well
make some scripts for it, because truthfully I don't want to waste brain cells
remembering how to configure it or which of the 900000000000000 flags GCC has that
I should be using.

The Chromium documentation basically says "Hey buddy listen, our project is so
out-of-hand that you really won't have the time to learn what you should about
how it works, so instead just learn enough to get by". Don't believe me?
[Look](http://chromium.org/developers/how-tos/getting-around-the-chrome-source-code/).

And the NW.js documentation isn't even part of the NW.js project. It's just
copy-pasted directly out of the Chromium documentation, with a few different
letters. Hell half the time it isn't even copy-pasted! There's often times just
a link. Thanks for the index of links. You should open a bookstore that just
sells maps instructing how to drive to another bookstore.

On top of that the whole process is shit. Glibc, GNU make, and 22GB of C++!
WOOHOO!!

*That* is why I'm automating the build process.

## You seem to dislike NW.js/Chromium/Node.js.

Here's a quote from Ryan Dahl (the creator of Node.js)

>I hate almost all software. It's unnecessary and complicated at almost every
>layer. At best I can congratulate someone for quickly and simply solving a
>problem on top of the shit that they are given. The only software that I like
>is one that I can easily understand and solves my problems. The amount of
>complexity I'm willing to tolerate i proportional to the size of the problem
>being solved.

>In the past year I think I have finally come to understand the ideals of Unix:
>file descriptors and processes orchestrated with C. It's a beautiful idea.
>This is no however what we interact with. The complexity was not contained.
>Instead I deal with DBus and /usr/lib and Boost and ioctls and SMF and
>signals and volatile variables and prototypal inheritance and C99FEATURES_ and
>dpkg and autoconf.

>Those of us who build on top of these systems are adding to the complexity. Not
>only do you have to understand $LD_LIBRARY_PATH to make your system work but
>now you have to understand $NODE_PATH too - there's my little addition to
>the complexity you must no know! The user - the one who just want to see a
>webpage - don't care. They don't care how we organize /usr, they don't care
>about zombie processes, they don't care about bash tab completion, they don't
>care if zlib is dynamically linked or statically linke to Node. There will come
>a point where the accumulated complexity of our existing systems is greater
>than the complexity of creating a new one. When that happens all of this shit
>will be trashed. We can flush boost and glib and autoconf down the toilet and
>never think of them again.

>Those of you who still find it enjoyable to learn the details of, say, a
>programming language - being able to happily recite off if NaN equals or does
>not equal null - you just don't yet understand how utterly fucked the whole
>thing is. If you think it would be cute to align all of the equals signs in
>your code, if you spend time configuring your window manager or editor, if put
>unicode check marks in your test runner, if you add unnecessary hierarchies in
>your code directories, if you are doing anything beyond just solving the
>problem - you don't understand how fucked the whole thing is. No one gives a
>fuck about the glib object model.

>The only thing that matters in software is the experience of the user.

Maybe one day I'll rewrite Popcorn Time in a good language, but that day is not
today.

## Whatever, how do I build this thing?

First, you'll need to get a copy of Ubuntu 14.04. Why? Well for one, trying to
build this outside of a sandbox will destroy your development environment. Oh
and get the "server edition" (it's headless) because some bullshit aspect of
Chromium requires X11 headers, but not the verson that comes with Ubuntu 14.04,
so you have to grab it out of the backports. Welcome to dependency hell.

Ubuntu 14.04 is the "officially supported" build environment. But even at that
there are some things that the script included in Chromium won't install. Don't
worry though, my scripts do.

Also, if you're building for a 32-bit arch, get the 32-bit Ubuntu.
Why? Because Glib is *the fucking worst thing to happen to modern computing*.
Here's my fair warning: don't even try it.

As far as the actual process goes...
```
git clone https://github.com/kjthegod/ptcenwjs.git/ && cd ptcenwjs/
./linux-amd64.sh
```
It's that easy.

Note that, you may have to `EXPORT` variables outside of the script on ia32
machines for them to stick. I really don't know why.

The NW.js tarball will be coppied into the folder along with the build scripts. The
scripts' names indicate what they build for.

To update your build environment simply
```
git pull
./clean.sh
```
and you're ready to go.

## License

Um. I'm not a fucking lawyer. But I'm pretty sure the binary you get from this
is under the GPLv3. So you can still bundle it with your MIT code with this and
not have it consumed by the retroactive virus that is the GNU/GPL; however, any
changes that you make to NW.js *itself* still fall under the GPL.

As for my scrips, they're public domain.
