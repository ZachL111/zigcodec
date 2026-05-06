const std = @import("std");

const Signal = struct {
    demand: i32,
    capacity: i32,
    latency: i32,
    risk: i32,
    weight: i32,
};

const threshold: i32 = 176;
const risk_penalty: i32 = 5;
const latency_penalty: i32 = 2;
const weight_bonus: i32 = 2;

fn score(signal: Signal) i32 {
    return signal.demand * 2 + signal.capacity + signal.weight * weight_bonus
        - signal.latency * latency_penalty - signal.risk * risk_penalty;
}

fn classify(signal: Signal) []const u8 {
    return if (score(signal) >= threshold) "accept" else "review";
}

test "fixture decisions" {
    const signal_case_1 = Signal{ .demand = 78, .capacity = 78, .latency = 25, .risk = 22, .weight = 7 };
    try std.testing.expectEqual(@as(i32, 88), score(signal_case_1));
    try std.testing.expect(std.mem.eql(u8, classify(signal_case_1), "review"));
    const signal_case_2 = Signal{ .demand = 97, .capacity = 102, .latency = 9, .risk = 10, .weight = 12 };
    try std.testing.expectEqual(@as(i32, 252), score(signal_case_2));
    try std.testing.expect(std.mem.eql(u8, classify(signal_case_2), "accept"));
    const signal_case_3 = Signal{ .demand = 84, .capacity = 82, .latency = 17, .risk = 10, .weight = 9 };
    try std.testing.expectEqual(@as(i32, 184), score(signal_case_3));
    try std.testing.expect(std.mem.eql(u8, classify(signal_case_3), "accept"));
}

const DomainReview = struct {
    signal: i32,
    slack: i32,
    drag: i32,
    confidence: i32,
};

fn domainReviewScore(item: DomainReview) i32 {
    return item.signal * 2 + item.slack + item.confidence - item.drag * 3;
}

fn domainReviewLane(item: DomainReview) []const u8 {
    const value = domainReviewScore(item);
    if (value >= 140) return "ship";
    if (value >= 105) return "watch";
    return "hold";
}

test "domain review lane" {
    const item = DomainReview{ .signal = 57, .slack = 24, .drag = 8, .confidence = 77 };
    try std.testing.expectEqual(@as(i32, 191), domainReviewScore(item));
    try std.testing.expect(std.mem.eql(u8, domainReviewLane(item), "ship"));
}
