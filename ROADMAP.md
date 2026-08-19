# ImpURI Roadmap

Date: 20260819

Jobs are in TODO.txt. What is here is undecided: questions to be answered rather
than work to be done, which is why they are prose and the jobs are a list.

## Open questions

### Encoding before breaking the string down

Consider encoding everything in the URI before breaking the string into parts, so
as to avoid the kind of complexity introduced in `ImpURI.has_userinfo?`.

This is a change of approach rather than a job. It names a cost in the present
design and proposes a different design which might avoid it, and nothing can be
done about it until somebody decides whether the trade is worth making.

### Whether the path separator should be settable

Be able to change the colon path separator for an ImpURI instance, say if
converting from ssh-form to the URI-form of an ssh resource. Any other uses?

The question is that last clause, and it was there from the start. One use was
named, and 0.12.0 met it from the other side: `#to_ssh` renders the ssh/scp form,
choosing the separator by what the resource was parsed from rather than letting the
caller set it. So the one motivating case is served without the separator being
settable at all. Whether anything else wants it remains open, and until something
does, this stays a question rather than becoming work.
