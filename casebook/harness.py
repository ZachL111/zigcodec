"""Executable checks for the zigcodec casebook."""

from __future__ import annotations

from collections import Counter

from . import zigcodec_segment_00
from . import zigcodec_segment_01
from . import zigcodec_segment_02
from . import zigcodec_segment_03
from . import zigcodec_segment_04
from . import zigcodec_segment_05
from . import zigcodec_segment_06
from . import zigcodec_segment_07
from . import zigcodec_segment_08
from . import zigcodec_segment_09
from .expected import EXPECTED
from .model import validate_case


def iter_cases():
    yield from zigcodec_segment_00.iter_zigcodec_00()
    yield from zigcodec_segment_01.iter_zigcodec_01()
    yield from zigcodec_segment_02.iter_zigcodec_02()
    yield from zigcodec_segment_03.iter_zigcodec_03()
    yield from zigcodec_segment_04.iter_zigcodec_04()
    yield from zigcodec_segment_05.iter_zigcodec_05()
    yield from zigcodec_segment_06.iter_zigcodec_06()
    yield from zigcodec_segment_07.iter_zigcodec_07()
    yield from zigcodec_segment_08.iter_zigcodec_08()
    yield from zigcodec_segment_09.iter_zigcodec_09()


def summarize_cases() -> dict:
    rows = list(iter_cases())
    for row in rows:
        validate_case(row)
    lanes = Counter(row.expected_lane for row in rows)
    focus = Counter(row.focus for row in rows)
    return {
        "case_count": len(rows),
        "score_min": min(row.expected_score for row in rows),
        "score_max": max(row.expected_score for row in rows),
        "lane_counts": dict(sorted(lanes.items())),
        "focus_counts": dict(sorted(focus.items())),
        "score_checksum": sum((index + 1) * row.expected_score for index, row in enumerate(rows)),
        "pressure_checksum": sum((index % 17 + 1) * row.pressure for index, row in enumerate(rows)),
    }


def assert_expected() -> dict:
    summary = summarize_cases()
    if summary != EXPECTED:
        raise AssertionError(f"casebook summary mismatch: {summary!r} != {EXPECTED!r}")
    return summary


def zigcodec_summary() -> dict:
    return assert_expected()
