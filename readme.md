<p align="center"><img src="banner.png" style="width: 20em;"></p>

<h1 align="center">Universal Chess Interface</h1>

<h3>Charter</h3>

The specification should, as a rule, be consistent with the <i>Description
of the Universal Chess Interface</i> (DescUCI) by Rudolf Huber and Stefan
Meyer-Kahlen.

In cases where the DescUCI leaves behavior unspecified or open to
interpretation, the specification should provide a precise answer. Decisions are
left to the discretion of the author and ad hoc committee, but should generally
simplify the implementation of engines.

The specification may decline to specify features that are varely rarely
used or are of no use to noncommercial developers (such as the `register`,
`registration`, and `copyprotection` messages).

In cases where the behavior of significant or widely-used clients or engines
does not conform with the DescUCI, the specification may contradict the DescUCI
and instead require or allow the behavior seen in practice.

The specification should govern only the protocol or interface that clients and
engines use to communicate (in other words, only behavior that is observable by
standard input and standard output). The intended meanings of messages should be
described in nonnormative comments.

The specification should document and clarify common behavior with the
expectation that clients and engines will often have additional functionality.

If the majority of the widely-used clients and engines exhibit a behavior that
is not mentioned by the DescUCI and there is some degree of historical precedent
(so that older clients and engines that still frequent would remain compatible),
the behavior may be required or allowed by the specification. If this is not
the case, but the behavior is becoming more common or ought to be standardized,
the specification ought to recommend (in nonnormative comments) support for the
behavior.

After the completion of the base specification, an addendum should be written
to document extensions, particularly backward-compatible extensions that are
advertised and negotiated with `UCI_` options.

<h3>License</h3>

The programs in this repository are protected by copyright. However, they are
available to you under the terms of version 3 of the GNU Affero General Public
License (AGPL). You are welcome to run the programs, modify them, copy them,
or use them in a project of your own. If you distribute a program in this
repository, verbatim or modified, you must provide the source and extend to
anyone who obtains a copy the same license that I am granting you.

The remaining works in this repository are also protected by copright.
However, they are available to you under the terms of version 4.0 of the
Creative Commons Attribution-NoDerivatives license (CC BY-ND). Informally,
this means you are free to copy and redistribute the works so long as you give
appropriate attribution and notice of the license, but you are not allowed to
distribute modified copies or derivative works.
