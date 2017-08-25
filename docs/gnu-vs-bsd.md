# GNU vs BSD

A faily good answer outlining the differences at [this stack overflow](https://unix.stackexchange.com/questions/79355/what-are-the-main-differences-between-bsd-and-gnu-linux-userland).

A bulleted summary of some key parts here:

- GNU programs tend to have both:
  - Single letter flags like `-s`
  - Long version flags like `--something-long`
  - Plainly speaking, this is much more user friendly &
    scriptable as long versions of flags require less
    brute-force memory.  Scripts written should use long
    form flags to attempt to be self documenting.  BASH
    isn't the greatest language to script in, so any helps
    to keep it maintainable/readable are good.
  - Tend towards POSIX compatibility
  - More at [gnu.org](https://www.gnu.org/philosophy/free-sw.en.html) about
    free software & the Free Software Foundation.
  - Richard Stallman is a key player in this.
- BSD programs
  - [Berkeley Software Distribution](www.freebsd.org)
  - Original ties to AT&T's work in UNIX
  - From freebsd.org, "BSD developers tend to be more experienced
    than Linux developers, and have less interest in making the
    system easy to use.  Newcomers tend to feel more comfortable
    with Linux."

As I think usability is a fundamental component of software
engineering, the GNU vibe is much more palatable to me.
