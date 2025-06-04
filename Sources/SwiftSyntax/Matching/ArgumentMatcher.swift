//
//  ArgumentMatcher.swift
//  swift-syntax
//
//  Created by Kim de Vos on 13/04/2025.
//


public struct CallArgumentMatcher {
  public static func matchCallArgumentsImpl(
    args: inout [FunctionParameterSyntax],
    params: [FunctionParameterSyntax],
    paramInfo: ParameterListInfo,
    unlabeledTrailingClosureArgIndex: Int?,
    allowFixes: Bool,
    trailingClosureMatching: TrailingClosureMatching,
    listener: MatchCallArgumentListener,
    parameterBindings: inout [ParamBinding]
  ) {
//    assert(params.size() == paramInfo.size() && "Default map does not match");
//    assert(!unlabeledTrailingClosureArgIndex ||
//           *unlabeledTrailingClosureArgIndex < args.size());
//
//    // Keep track of the parameter we're matching and what argument indices
//    // got bound to each parameter.
//    unsigned numParams = params.size();
//    parameterBindings.clear();
//    parameterBindings.resize(numParams);
//
//    // Keep track of which arguments we have claimed from the argument tuple.
//    unsigned numArgs = args.size();
//    SmallVector<bool, 4> claimedArgs(numArgs, false);
//    SmallVector<Identifier, 4> actualArgNames;
//    unsigned numClaimedArgs = 0;
//
//    // Indicates whether any of the arguments are potentially out-of-order,
//    // requiring further checking at the end.
//    bool potentiallyOutOfOrder = false;
//
//    // Local function that claims the argument at \c argIdx, returning the
//    // index of the claimed argument. This is primarily a helper for
//    // \c claimNextNamed.
//    auto claim = [&](Identifier expectedName, unsigned argIdx,
//                     bool ignoreNameClash = false)  -> unsigned {
//      // Make sure we can claim this argument.
//      assert(argIdx != numArgs && "Must have a valid index to claim");
//      assert(!claimedArgs[argIdx] && "Argument already claimed");
//
//      if (!actualArgNames.empty()) {
//        // We're recording argument names; record this one.
//        actualArgNames[argIdx] = expectedName;
//      } else if (!ignoreNameClash && !args[argIdx].matchParameterLabel(expectedName)) {
//        // We have an argument name mismatch. Start recording argument names.
//        actualArgNames.resize(numArgs);
//
//        // Figure out previous argument names from the parameter bindings.
//        for (auto i : indices(params)) {
//          const auto &param = params[i];
//          bool firstArg = true;
//
//          for (auto argIdx : parameterBindings[i]) {
//            actualArgNames[argIdx] = firstArg ? param.getLabel() : Identifier();
//            firstArg = false;
//          }
//        }
//
//        // Record this argument name.
//        actualArgNames[argIdx] = expectedName;
//      }
//
//      claimedArgs[argIdx] = true;
//      ++numClaimedArgs;
//      return argIdx;
//    };
//
//    // Local function that skips over any claimed arguments.
//    auto skipClaimedArgs = [&](unsigned &nextArgIdx) {
//      while (nextArgIdx != numArgs && claimedArgs[nextArgIdx])
//              ++nextArgIdx;
//      return nextArgIdx;
//    };
//
//    // Local function that retrieves the next unclaimed argument with the given
//    // name (which may be empty). This routine claims the argument.
//    auto claimNextNamed =
//    [&](unsigned &nextArgIdx, Identifier paramLabel, bool ignoreNameMismatch,
//        bool forVariadic = false) -> std::optional<unsigned> {
//      // Skip over any claimed arguments.
//      skipClaimedArgs(nextArgIdx);
//
//      // If we've claimed all of the arguments, there's nothing more to do.
//      if (numClaimedArgs == numArgs)
//          return std::nullopt;
//
//      // Go hunting for an unclaimed argument whose name does match.
//      std::optional<unsigned> claimedWithSameName;
//      unsigned firstArgIdx = nextArgIdx;
//      for (unsigned i = nextArgIdx; i != numArgs; ++i) {
//        auto argLabel = args[i].getLabel();
//        bool claimIgnoringNameMismatch = false;
//
//        if (!args[i].matchParameterLabel(paramLabel)) {
//          // If this is an attempt to claim additional unlabeled arguments
//          // for variadic parameter, we have to stop at first labeled argument.
//          if (forVariadic)
//              return std::nullopt;
//
//          if ((i == firstArgIdx || ignoreNameMismatch) &&
//              listener.canClaimArgIgnoringNameMismatch(args[i])) {
//            // Avoid triggering relabelling fixes about the completion arg.
//            claimIgnoringNameMismatch = true;
//          } else {
//            // Otherwise we can continue trying to find argument which
//            // matches parameter with or without label.
//            continue;
//          }
//        }
//
//        // Skip claimed arguments.
//        if (claimedArgs[i]) {
//          assert(!forVariadic && "Cannot be for a variadic claim");
//          // Note that we have already claimed an argument with the same name.
//          if (!claimedWithSameName)
//              claimedWithSameName = i;
//          continue;
//        }
//
//        // We found a match.  If the match wasn't the next one, we have
//        // potentially out of order arguments.
//        if (i != nextArgIdx) {
//          assert(!forVariadic && "Cannot be for a variadic claim");
//          // Avoid claiming un-labeled defaulted parameters
//          // by out-of-order un-labeled arguments or parts
//          // of variadic argument sequence, because that might
//          // be incorrect:
//          // ```swift
//          // func foo(_ a: Int, _ b: Int = 0, c: Int = 0, _ d: Int) {}
//          // foo(1, c: 2, 3) // -> `3` will be claimed as '_ b:'.
//          // ```
//          if (argLabel.empty() && !claimIgnoringNameMismatch)
//              continue;
//
//          potentiallyOutOfOrder = true;
//        }
//
//        // Claim it.
//        return claim(paramLabel, i, claimIgnoringNameMismatch);
//      }
//
//      // If we're not supposed to attempt any fixes, we're done.
//      if (!allowFixes)
//          return std::nullopt;
//
//      // Several things could have gone wrong here, and we'll check for each
//      // of them at some point:
//      //   - The keyword argument might be redundant, in which case we can point
//      //     out the issue.
//      //   - The argument might be unnamed, in which case we try to fix the
//      //     problem by adding the name.
//      //   - The argument might have extraneous label, in which case we try to
//      //     fix the problem by removing such label.
//      //   - The keyword argument might be a typo for an actual argument name, in
//      //     which case we should find the closest match to correct to.
//
//      // Missing or extraneous label.
//      if (nextArgIdx != numArgs && ignoreNameMismatch) {
//        auto argLabel = args[nextArgIdx].getLabel();
//        // Claim this argument if we are asked to ignore labeling failure,
//        // only if argument doesn't have a label when parameter expected
//        // it to, or vice versa.
//        if (paramLabel.empty() || argLabel.empty())
//            return claim(paramLabel, nextArgIdx);
//      }
//
//      // Redundant keyword arguments.
//      if (claimedWithSameName) {
//        // FIXME: We can provide better diagnostics here.
//        return std::nullopt;
//      }
//
//      // Typo correction is handled in a later pass.
//      return std::nullopt;
  }
}
